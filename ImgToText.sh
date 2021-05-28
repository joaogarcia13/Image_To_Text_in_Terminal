#/bin/sh

#cada caracter equivale a 3x5px
#se nao tiver parametros imprime esta mensagem e sai.

if [ $# -eq 0 ]
then
	echo
	echo "Utilização: Tranforma uma imagem para texto."
	echo "Exemplo: './ImgToText.sh [diretorio da imagem] [cor do texto]"
	echo "As Cores disponiveis são branco, preto, vermelho, verde, azul,rosa, amarelo, castanho, laranja e roxo."
	echo
	exit 1
fi

if [ $# -eq 2 ]
then
	dir=$(pwd)
	#copia imagem para a pasta dos Scripts e muda o nome para copia
	mkdir pastaTemp
	cp $1 $dir/pastaTemp
       	mv $dir/pastaTemp/$(basename $1) $dir/pastaTemp/copia	
	img=$dir/pastaTemp/copia

	 #redimensiona a imagem para ter 400px de altura mas manter proporçoes -> comando vem da biblioteca ImageMagick
	convert $img -resize 400x $img
	cd pastaTemp
	
	#reparte a imagem em retagulos no tamanho de um caracter 3x5px 
	img2=`convert $img -format "%wx%h" info:`	
	convert \( -size $img2 xc:none \) null: \( $img -crop 3x5% \) -layers composite img.png 
	
	#apaga a copia
	rm copia

	#organiza pasta


	num=0
	echo " "
	for i in $dir/pastaTemp/*	
	do

		imgTemp=$dir/pastaTemp/img-$num.png #isto esta aqui para obrigar o o codigo que esta aseguir a percorrer os ficheiros por ordem
		#echo "$imgTemp"		
		#encontra a cor predominante em cada bloco de 3x5px, cada bloco é = bit
		bit=$(convert $imgTemp -resize 1x1\! \
    -format "%[fx:int(255*r+.5)],%[fx:int(255*g+.5)],%[fx:int(255*b+.5)]" info:-)
		#divide os valores de rgb retornados acima em red, green e blue
		
		red=${bit%%,*}     #corta de bits a substring mais longa que conseguir encontrar com o padrao que corresponde a algo separado po virgulas a acabar na primeira virgula
		green=${bit%,*}    #corta de bits a primeira substring que encontrara partir do fim ate a primeira virgula que econtrar
		green=${green#*,}  #faz o mesmo que o anterior mas a partir do inicio para o fim
		blue=${bit##*,}    #corta de bits a substring mais longa que encontrar a paritr do começo ate á ultima virgula que encontrar
		
		#se algum dos valores for maior que 200 o bloco é considerado branco
		if [ $red -gt 250 -o $green -gt 250 -o $blue -gt 250 ]
		then
			printf ' '
		else
			#tput setaf 6
			tput bold
			printf '/'
		fi
		
		#imprime uma new line a cada 34 casas
		resto=$(($num%35))
		if [ $resto -eq 0 ]
		then
			printf '\n'
		fi
		num=$((num+1))
	done
	
	printf '\n'

	#limpa o directorio e apaga a pasta depois da conversão
	cd ..
	rm -r $dir/pastaTemp
else
	exit 1
fi


