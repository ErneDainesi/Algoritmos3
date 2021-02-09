
class Cart():

    def __init__(self, client_id, client_pass):
        self.client_id = client_id
        self.client_pass = client_pass
        self.cart_elements = {}
        self.cart_id = client_id
    
    def elements_in_cart(self):
        return len(self.cart_elements)

    def add_to_cart(self, cart_id, isbn, quantity):
        if quantity < 1: return False
        self.cart_elements[cart_id] = {isbn: quantity}
        return True

    def get_cart_id(self):
        return self.cart_id