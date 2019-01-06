require_relative 'inicializar'
require_relative "boneco"
require_relative 'lista'

class Forca
    attr_accessor :categoria
    attr_accessor :palavra #Palavra sorteada
    attr_accessor :cont_palavra #conta quantas letras tem a palavra
    attr_accessor :qtd_tent #limite de tentativas
    attr_accessor :str_tent
    attr_accessor :erros #Definia mensagem a ser exibida
    attr_accessor :letra
    attr_accessor :qtd_letra
    attr_accessor :resul #recebe as litas da tentativa e distribui na linha
    attr_accessor :linha #linha em baixo das letras das tentativas
       
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

    def sortea_palavra()
        #loop para selecionar a categoria das palavras
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

        #Verifica a quantidade de palavras possíveis na categoria e seleciona uma aleatória
        @qtd_categ = Lista.categorias[@categoria].size
        @qtd_categ -= 1
        chave = Random.rand(0..@qtd_categ)
        @palavra = Lista.categorias[@categoria][chave].split('')
        @qtd_letra = @palavra.size
    end

    def saida (tent, erro)

        puts "Palavra com #{@qtd_letra} letras, categoria #{@categoria}"
        puts""

        cont_str = @str_tent.size
        i = 0
        while i <= cont_str
            print "#{@str_tent[i]} "
            
            i += 1
        end

        puts " "
        puts " "
       
        Boneco.boneco(tent, erros)
    
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

    def jogar

        i=0
        tent = 0
        

        #Gabarito das posições de cada @letra esperada pelo jogador
        while i < @qtd_letra 
            @resul[i] = " "
            @linha[i] = "_   "
            i += 1
        end

        #Inicia um jogo em um loop até o jogador acertar ou estrapolar as tentativas
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