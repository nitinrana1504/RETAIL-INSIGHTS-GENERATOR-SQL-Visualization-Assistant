import google.generativeai as genai

GENAI_KEY = "your_gemini_api_key"
genai.configure(api_key=GENAI_KEY)
model = genai.GenerativeModel("gemini-2.0-flash")

MYSQL_USER = "root"
MYSQL_PASSWORD = "1234"
MYSQL_HOST = "localhost"
MYSQL_PORT = "3306"
MYSQL_DATABASE = "Darkness"
DATABASE_URL = f"mysql+pymysql://{MYSQL_USER}:{MYSQL_PASSWORD}@{MYSQL_HOST}:{MYSQL_PORT}/{MYSQL_DATABASE}"

few_shots = [
    {
        'Question': "Which product generated the highest revenue?",
        'SQLQuery': """
            SELECT p.product_name, SUM(s.selling_price * o.order_quantity) AS total_revenue
            FROM order_detail_fact o
            JOIN sku_detail_dim s ON o.sku_id = s.sku_id
            JOIN product_detail_subdim p ON s.product_id = p.product_id
            GROUP BY p.product_name
            ORDER BY total_revenue DESC
            LIMIT 1
        """
    },
    {
        'Question': "Which product category is the most profitable?",
        'SQLQuery': """
            SELECT c.category_name, SUM(s.selling_price * o.order_quantity) AS revenue
            FROM order_detail_fact o
            JOIN sku_detail_dim s ON o.sku_id = s.sku_id
            JOIN product_detail_subdim p ON s.product_id = p.product_id
            JOIN category_detail_subdim c ON p.category_id = c.category_id
            GROUP BY c.category_name
            ORDER BY revenue DESC
            LIMIT 1
        """
    },
    {
        'Question': "How much revenue did we generate each month?",
        'SQLQuery': """
            SELECT MONTH(sd.shipping_date) AS month, YEAR(sd.shipping_date) AS year, 
                   SUM(s.selling_price * o.order_quantity) AS monthly_revenue
            FROM order_detail_fact o
            JOIN sku_detail_dim s ON o.sku_id = s.sku_id
            JOIN shipping_detail_dim sd ON o.tracking_id = sd.tracking_id
            GROUP BY year, month
            ORDER BY year, month
        """
    },
    {
        'Question': "Which seller has generated the most revenue?",
        'SQLQuery': """
            SELECT s.seller_name, SUM(sku.selling_price * o.order_quantity) AS total_revenue
            FROM order_detail_fact o
            JOIN sku_detail_dim sku ON o.sku_id = sku.sku_id
            JOIN seller_detail_dim s ON o.seller_id = s.seller_id
            GROUP BY s.seller_name
            ORDER BY total_revenue DESC
            LIMIT 1
        """
    },
    {
        'Question': "How many active members are in the customer base?",
        'SQLQuery': """
            SELECT COUNT(*) AS active_members 
            FROM customer_detail_dim 
            WHERE membership_status = 'TRUE'
        """
    },
    {
        'Question': "Which cities have the highest number of customers?",
        'SQLQuery': """
            SELECT city, COUNT(*) AS customer_count
            FROM customer_detail_dim
            GROUP BY city
            ORDER BY customer_count DESC
        """
    },
    {
        'Question': "Which customer has spent the most money overall?",
        'SQLQuery': """
            SELECT c.customer_name, SUM(s.selling_price * o.order_quantity) AS total_spent
            FROM order_detail_fact o
            JOIN sku_detail_dim s ON o.sku_id = s.sku_id
            JOIN customer_detail_dim c ON o.customer_id = c.customer_id
            GROUP BY c.customer_name
            ORDER BY total_spent DESC
            LIMIT 1
        """
    },
    {
        'Question': "What is the gender distribution of customers?",
        'SQLQuery': """
            SELECT gender, COUNT(*) AS count 
            FROM customer_detail_dim 
            GROUP BY gender
        """
    },
    {
        'Question': "Which SKUs have low stock (less than 20 units)?",
        'SQLQuery': """
            SELECT sku_id, inventory_quantity
            FROM inventory_detail_fact
            WHERE inventory_quantity < 20
            ORDER BY inventory_quantity ASC
        """
    },
    {
        'Question': "Which warehouse is using the least of its capacity?",
        'SQLQuery': """
            SELECT w.warehouse_name, w.warehouse_capacity, SUM(i.inventory_quantity) AS used_capacity
            FROM warehouse_detail w
            JOIN inventory_detail_fact i ON w.warehouse_id = i.warehouse_id
            GROUP BY w.warehouse_id
            ORDER BY (w.warehouse_capacity - SUM(i.inventory_quantity)) DESC
            LIMIT 1
        """
    },
    {
        'Question': "Which seller has the most unsold inventory?",
        'SQLQuery': """
            SELECT s.seller_name, SUM(i.inventory_quantity) AS total_unsold
            FROM inventory_detail_fact i
            JOIN seller_detail_dim s ON i.seller_id = s.seller_id
            GROUP BY s.seller_name
            ORDER BY total_unsold DESC
            LIMIT 1
        """
    },
    {
        'Question': "Which coupon code was used the most?",
        'SQLQuery': """
            SELECT coupon_code, COUNT(*) AS usage_count
            FROM transaction_detail_dim
            GROUP BY coupon_code
            ORDER BY usage_count DESC
            LIMIT 1
        """
    },
    {
        'Question': "What is the average discount offered per transaction?",
        'SQLQuery': """
            SELECT AVG(total_discount_amount) AS avg_discount 
            FROM transaction_detail_dim
        """
    },
    {
        'Question': "Which product has received the highest total discount?",
        'SQLQuery': """
            SELECT p.product_name, SUM(s.discount_amount * o.order_quantity) AS total_discount
            FROM order_detail_fact o
            JOIN sku_detail_dim s ON o.sku_id = s.sku_id
            JOIN product_detail_subdim p ON s.product_id = p.product_id
            GROUP BY p.product_name
            ORDER BY total_discount DESC
            LIMIT 1
        """
    },
    {
        'Question': "Which shipping method is used most frequently?",
        'SQLQuery': """
            SELECT shipping_method, COUNT(*) AS usage_count
            FROM shipping_detail_dim
            GROUP BY shipping_method
            ORDER BY usage_count DESC
            LIMIT 1
        """
    },
    {
        'Question': "Which shipper has the most delayed deliveries?",
        'SQLQuery': """
            SELECT s.shipper_name, COUNT(*) AS delay_count
            FROM shipping_detail_dim sd
            JOIN shipper_detail_subdim s ON sd.shipper_id = s.shipper_id
            WHERE actual_delivery_date > estimated_delivery_date
            GROUP BY s.shipper_name
            ORDER BY delay_count DESC
            LIMIT 1
        """
    },
    {
        'Question': "Which product has the highest return count?",
        'SQLQuery': """
            SELECT p.product_name, COUNT(*) AS return_count
            FROM order_detail_fact o
            JOIN sku_detail_dim sku ON o.sku_id = sku.sku_id
            JOIN product_detail_subdim p ON sku.product_id = p.product_id
            WHERE o.return_id IS NOT NULL
            GROUP BY p.product_name
            ORDER BY return_count DESC
            LIMIT 1
        """
    },
    {
        'Question': "What are the most common return statuses?",
        'SQLQuery': """
            SELECT return_status, COUNT(*) AS count
            FROM return_detail_dim
            GROUP BY return_status
            ORDER BY count DESC
        """
    },
    {
        'Question': "Which product received the most 1-star or 2-star reviews?",
        'SQLQuery': """
            SELECT p.product_name, COUNT(*) AS low_rating_count
            FROM order_detail_fact o
            JOIN sku_detail_dim sku ON o.sku_id = sku.sku_id
            JOIN product_detail_subdim p ON sku.product_id = p.product_id
            JOIN review_detail_dim r ON o.review_id = r.review_id
            WHERE r.rating <= 2
            GROUP BY p.product_name
            ORDER BY low_rating_count DESC
            LIMIT 1
        """
    },
    {
        'Question': "What is the average rating of each product?",
        'SQLQuery': """
            SELECT p.product_name, AVG(r.rating) AS average_rating
            FROM order_detail_fact o
            JOIN sku_detail_dim sku ON o.sku_id = sku.sku_id
            JOIN product_detail_subdim p ON sku.product_id = p.product_id
            JOIN review_detail_dim r ON o.review_id = r.review_id
            GROUP BY p.product_name
            ORDER BY average_rating DESC
        """
    },
    {
        'Question': "Which products have more than 3 reviews and are rated above 4.5?",
        'SQLQuery': """
            SELECT p.product_name, AVG(r.rating) AS avg_rating, COUNT(*) AS review_count
            FROM order_detail_fact o
            JOIN sku_detail_dim sku ON o.sku_id = sku.sku_id
            JOIN product_detail_subdim p ON sku.product_id = p.product_id
            JOIN review_detail_dim r ON o.review_id = r.review_id
            GROUP BY p.product_name
            HAVING review_count > 3 AND avg_rating > 4.5
            ORDER BY avg_rating DESC
        """
    },
    {
        'Question': "Which review heading appears most frequently?",
        'SQLQuery': """
            SELECT review_heading, COUNT(*) AS count
            FROM review_detail_dim
            GROUP BY review_heading
            ORDER BY count DESC
            LIMIT 1
        """
    },
    {
        'Question': "What is the count of successful, pending, and failed transactions?",
        'SQLQuery': """
            SELECT transaction_status, COUNT(*) AS count
            FROM transaction_detail_dim
            GROUP BY transaction_status
        """
    },
    {
        'Question': "Which payment method is used most often?",
        'SQLQuery': """
            SELECT transaction_type, COUNT(*) AS count
            FROM transaction_detail_dim
            GROUP BY transaction_type
            ORDER BY count DESC
            LIMIT 1
        """
    },
    {
        'Question': "Which coupon code has generated the most discount amount?",
        'SQLQuery': """
            SELECT coupon_code, SUM(total_discount_amount) AS total_discount
            FROM transaction_detail_dim
            GROUP BY coupon_code
            ORDER BY total_discount DESC
            LIMIT 1
        """
    }
]

