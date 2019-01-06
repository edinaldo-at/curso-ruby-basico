#faz a requisição dos arquivos necessários 

require_relative 'inicializar'
require_relative "boneco"
require_relative 'lista'

#cria a classe Forca
class Forca
    attr_accessor :categoria #categoria da palavra que será sorteada
    attr_accessor :palavra #Palavra sorteada
    attr_accessor :qtd_letra #recebe o size da palavra, ou seja a quantidade de letras
    attr_accessor :letra #recebe e aletra da tentativa da vez
    attr_accessor :qtd_tent #limite de tentativas
    attr_accessor :str_tent #recebe todas a letras para mostrar quais já foram usadas
    attr_accessor :erros #será true quando acertar e false quando errar a tentativa
    attr_accessor :resul #recebe e distribui as letras de acordo com a posição sobre a linha
    attr_accessor :linha #linha em baixo das letras das tentativas
     
    #chama a classe de inicialização, atribui valores aos atributos e chama o metodo que sorteia a palavra
    def initialize()
        Inicializacao.inicializando
        @categoria = ""
        @qtd_tent = 0
        @str_tent = []
        @erros = ""
        @letra = ""
        @qtd_letra = ""
        @resul = {}
        @linha = {}
        sortea_palavra()
    end

    #Cria um menu para o jogador selecionar a categoria desejada
    def sortea_palavra()
        v1 = 0
        while v1 == 0 || v1 == "Opção invalida"
            puts "ESCOLHA A CATEGORIA DE ACORDO COM O NÚMERO"
            puts ""
            puts "1 - Pessoas"
            puts "2 - Animais"
            puts "3 - Carros"
            puts ""
            v1 = gets.chomp.to_i

            case v1
                when 1
                    @categoria = :pessoas
                when 2
                    @categoria = :animais
                when 3
                    @categoria = :carros
                else
                    if v1 < 1 || v1 > 3 then
                        puts "Opção invalida"
                    end
            end
        end #fim

        #limpa a tela
        system('clear')

        #Verifica a quantidade de palavras da categoria e seleciona uma aleatoriamente
        @qtd_categ = Lista.categorias[@categoria].size
        @qtd_categ -= 1
        chave = Random.rand(0..@qtd_categ)
        @palavra = Lista.categorias[@categoria][chave].split('')
        @qtd_letra = @palavra.size
    end

    #contem as principair saidas de texto na tela
    def saida (tent, erro)

        puts "Palavra com #{@qtd_letra} letras, categoria #{@categoria}"
        puts""

        #Prita na tela todas as letras que ja foram usadas
        cont_str = @str_tent.size
        i = 0
        while i <= cont_str
            print "#{@str_tent[i]} "
            
            i += 1
        end

        puts " "
        puts " "
       
        #Exibe o desenha da forca
        Boneco.boneco(tent, erros)
    
        #Printa as letras e a linha em ordem na tela
        @resul.each {|key, value|   
            print value + "   "
        }
        puts " "
        @linha.each {|key, value|
            print value
        }
        puts " "
        puts " "
    end

    #faz todo o processamento do jogo
    def jogar

        i=0
        tent = 0
        
        #com base na quantidade de letras da palavra, define a quantidade de posição das letras e da linha decorativa
        while i < @qtd_letra 
            @resul[i] = " "
            @linha[i] = "_   "
            i += 1
        end

        #Compara a letra informada pelo jogador com cada posição do array palavra e distribui o que for igual ao hash resul
        while @resul.has_value?(" ") && tent < 6
            
            if @erros == true

                saida(tent, @erros)

                puts "Você acertou, digite a próxima letra"
                puts " "
                
                @letra = gets.chomp.to_s

                @erros = false
                
            elsif @erros == false

                tent += 1

                saida(tent, @erros)
               
                puts "Você errou, tente novamente"
                puts " "
                @letra = gets.chomp.to_s

            else
                
                saida(tent, @erros)
    
                puts "Digite uma letra"
                puts " "

                @letra = gets.chomp.to_s

                @erros = false

            end
            system("clear")
            
            @str_tent.push(@letra)

            @resul.each {|key, value|

                if @letra == @palavra[key]
                    @resul[key] = @letra
                    @erros = true
                end
    
            }
        end #fim do loop somente após acertar a palavra
        @qtd_tent = tent
    end
end