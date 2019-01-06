#Cria a classe de inicialização do jogo
class Inicializacao
  system('clear')

  def self.inicializando
      puts "TO NA FORCA 2019"
      print "Iniciando o Jogo."
      
      4.times do |i|
          sleep 1
          print "."
      end

      puts ""
      system('clear')
  end
end