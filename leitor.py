import re
from typing import NamedTuple

file = open('codigo.prog', 'r').read()

class Token(NamedTuple):
    type: str
    value: str
    line: int
    column: int

def tokenize(code):
    keywords = {'programa','se', 'entao', 'senao', 'enquanto', 'faca', 'para', 'int', 'real', 'char', 'OR', 'AND', 'NOT'}
    token_specification = [
        ('ConstReal', r'\d(\d)*\.\d(\d)*'),   
        ('ConstInt', r'\d(\d)*'), 
        ('ConstChar', r'\'[\w+]?\''),
        ('opAtribuicao',   r':='),          
         ('virg',      r','),           
        ('PVirg',      r';'),           
        ('opAdicao', r'\+'),                    
        ('opSubtracao', r'-'),                   
        ('opMult', r'\*'),                    
        ('opDiv', r'\/'),                     
        ('AbreParentese', r'\('),          
        ('FechaParentese', r'\)'),          
        ('AbreChave', r'\{'),                
        ('FechaChave', r'\}'),              
        ('opMenorIgual', r'<='),              
        ('opMaiorIgual', r'>='),   
        ('opMaior', r'>'),
        ('opMenor', r'<'),
        ('opDiferente', r'<>'),             
        ('opIgual', r'=='),             
        ('ID',       r'(?<!\w)[a-zA-Z]\w*'),    
        ('NEWLINE',  r'\n'),          
        ('SKIP',     r'[ \t]+'),       
        ('MISMATCH', r'.'),           
    ]
    tok_regex = '|'.join('(?P<%s>%s)' % pair for pair in token_specification)
    line_num = 1
    line_start = 0
    for mo in re.finditer(tok_regex, code):
        tipo = mo.lastgroup
        value = mo.group()
        column = mo.start() - line_start
        if tipo == 'ID' and value in keywords:
            if value == 'AND':
                tipo = 'opAnd'
            elif value == 'OR':
                tipo = 'opOr'
            elif value == 'NOT':
                        tipo = 'opNot'  
            elif value == 'int':
                        tipo = 'tipoInt'       
            elif value == 'real':
                        tipo = 'tipoReal'
            elif value == 'char':
                        tipo = 'tipoChar'
            else:
                tipo = value.upper()
        elif tipo == 'NEWLINE':
            line_start = mo.end()
            line_num += 1
            continue
        elif tipo == 'SKIP':
            continue
        elif tipo == 'MISMATCH':
            raise RuntimeError(f'{value!r} unexpected on line {line_num}')
        yield Token(tipo, value, line_num, column)





for token in tokenize(file):
    print(token)


