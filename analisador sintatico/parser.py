
class Parser:
    def __init__(self, tokens):
        self.tokens = tokens
        self.token_idx = 0
        self.advance()


    def advance(self):
        self.token_idx +=1
        if self.token_idx < len(self.tokens):
            self.current_token = self.tokens[self.token_idx]
    
    def factor():
        token = self.current_token
        if token_type in ('INT', 'REAL'):



    def 

