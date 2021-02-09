import unittest
from cart import Cart

class TusLibrosTests(unittest.TestCase):

    def test01_a_new_cart_is_empty(self):
        client_id = "123"
        client_pass = "123"
        cart = Cart(client_id, client_pass)
        self.assertEqual(cart.elements_in_cart(), 0)
    
    def test02_an_item_can_be_added_to_a_cart(self):
        client_id = "123"
        client_pass = "123"
        cart = Cart(client_id, client_pass)
        cart_id = cart.get_cart_id()
        isbn = "456"
        book_quantity = 1
        self.assertTrue(cart.add_to_cart(cart_id, isbn, book_quantity))
    
    def test03_book_can_be_added_twice_to_cart(self):
        client_id = "123"
        client_pass = "123"
        cart = Cart(client_id, client_pass)
        cart_id = cart.get_cart_id()
        isbn = "456"
        book_quantity = 1
        self.assertTrue(cart.add_to_cart(cart_id, isbn, book_quantity))
        self.assertTrue(cart.add_to_cart(cart_id, isbn, book_quantity))
        self.assertEqual() #chequear cantidad correcta





if __name__ == '__main__':
    unittest.main()