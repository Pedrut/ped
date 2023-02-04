#Pedro Felipe

def verbo_ou_nao(palavra):
    verbos = ["en", "es", "ei", "em", "est", "e", "im", "ai","os","na","am"]
    for verbo in verbos:
        if palavra.endswith(verbo):
            return True
    return False

def identifica_pessoa_e_tempo(palavra):
    if palavra.endswith("en"):
        return "presente", 3
    elif palavra.endswith("es"):
        return "presente", 2
    elif palavra.endswith("ei"):
        return "pretérito", 3
    elif palavra.endswith("em"):
        return "futuro", 4
    elif palavra.endswith("est"):
        return "presente", 5
    elif palavra.endswith("e"):
        return "pretérito", 3
    elif palavra.endswith("im"):
        return "futuro", 6
    elif palavra.endswith("ai"):
        return "futuro", 1
    elif palavra.endswith("os"):
        return "presente", 2
    elif palavra.endswith("el"):
        return "tempo verbal específico", None
    elif palavra.endswith("na"):
        return "presente", 3
    elif palavra.endswith("am"):
        return "presente", 6
    else:
        return None

def analisa_verbo(palavra):
    if verbo_ou_nao(palavra):
        tempo, pessoa = identifica_pessoa_e_tempo(palavra)
        return "verbo {}, {}".format(palavra[:-2] + "en", tempo), pessoa
    else:
        return "não é um tempo verbal", None

def processa_entrada(entrada):
    for linha in entrada:
        palavra = linha.strip()
        resultado, pessoa = analisa_verbo(palavra)
        if pessoa:
            print("{} - {} {}a pessoa".format(palavra, resultado, pessoa))
        else:
            print("{} - {}".format(palavra, resultado))

entrada = """casos
porre
corraem
picel
oficina
param"""

processa_entrada(entrada.strip().split("\n"))
