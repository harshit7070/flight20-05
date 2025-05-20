def create_connection():
    try:
        connection = mysql.connector.connect(
            host='localhost',
            database='flight',
            user='root',  # Make sure this is your actual MySQL username
            password='1234'   # Make sure this is your actual MySQL password
        )
        if connection.is_connected():
            return connection
    except Error as e:
        print(f"Error connecting to MySQL: {e}")  # Enhanced error message for debugging
        return None

/* import mysql.connector
from mysql.connector import Error

# Database configuration
DB_CONFIG = {
    'host': 'localhost',
    'database': 'flight',
    'user': 'root',  # Change to your MySQL username
    'password': '1234'   # Change to your MySQL password
}

def create_connection():
    """Create a connection to the MySQL database"""
    try:
        connection = mysql.connector.connect(**DB_CONFIG)
        if connection.is_connected():
            return connection
    except Error as e:
        print(f"Error: {e}")
        return None

def execute_query(query, params=None, fetchone=False, fetchall=False, commit=False):
    """Execute a query and return the result if needed"""
    connection = create_connection()
    cursor = None
    result = None
    
    if connection:
        try:
            cursor = connection.cursor(dictionary=True)
            cursor.execute(query, params or ())
            
            if fetchone:
                result = cursor.fetchone()
            elif fetchall:
                result = cursor.fetchall()
            
            if commit:
                connection.commit()
                result = cursor.lastrowid
                
            return result
        except Error as e:
            print(f"Error: {e}")
            return None
        finally:
            if cursor:
                cursor.close()
            if connection.is_connected():
                connection.close()
    return None

def initialize_database():
    """Check if required tables exist and create them if not"""
    # Check if Password column exists in User table
    query = """
    SELECT COUNT(*) as count
    FROM information_schema.COLUMNS 
    WHERE TABLE_SCHEMA = 'flight' 
    AND TABLE_NAME = 'User' 
    AND COLUMN_NAME = 'Password'
    """
    result = execute_query(query, fetchone=True)
    
    if result and result['count'] == 0:
        # Add Password column
        query = "ALTER TABLE User ADD COLUMN Password VARCHAR(255) NOT NULL"
        execute_query(query, commit=True)
        print("Added Password column to User table")

    # Add admin user if none exists
    query = "SELECT COUNT(*) as count FROM User WHERE Role = 'Admin'"
    result = execute_query(query, fetchone=True)
    
    if result and result['count'] == 0:
        from werkzeug.security import generate_password_hash
        
        # Create admin user
        query = """
        INSERT INTO User (Name, Email, Password, Role) 
        VALUES (%s, %s, %s, %s)
        """
        params = ('Admin User', 'admin@flight.com', generate_password_hash('admin123'), 'Admin')
        execute_query(query, params, commit=True)
        print("Created default admin user") */