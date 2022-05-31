
LLI="lli"
LLAMA="./llama.native"
TESTONE="./test1.native"
TESTTWO="./test2.native"

Usage() {
    banner
    echo "#===========================================================================================================================#"
    echo "#                                     LLAMA LANG - TESTING LLAMA                                                            #"                  
    echo "#===========================================================================================================================#"
    echo "# usage: ./testingllama [options] [<file.ll>]                                                                               #"                  
    echo "#                                                                                                                           #"                  
    echo "# options:                                                                                                                  #"
    echo "#   -a | --all tests all test files                                                                                         #" 
    echo "#   -f | --file test a specific file                                                                                        #"
    echo "#   -h | --help prints usage                                                                                                #"
    echo "#   -i | --interactive enters interactive mode                                                                              #"
    echo "#   --prim tests all files in test/primitives directory                                                                     #"
    echo "#   --cont tests all files in test/control    directory                                                                     #"
    echo "#   --func tests all files in test/functions  directory                                                                     #"
    echo "#   --fail tests all files in test/failures   directory                                                                     #"
    echo "#   --clean removes all .err .output .llama files from test/ out/ directories                                               #"
    echo "#                                                                                                                           #"                  
    echo "#===========================================================================================================================#"
    exit 1
}
Run() {
    eval $* 1>&2
}
ALL=./test/successes

PRIMITIVES=./test/successes/Primitives
CONTROL=./test/successes/control
FUNCTIONS=./test/successes/functions
FAILURES=./test/failures


banner(){
  echo "
    ----------------------------------------------------------------------------------------------------------------------------
                                                 _ _                       
                                                | | |                      
                                                | | | __ _ _ __ ___ _ __ _ 
                                                | | |/ _  | '_  '_' |/ _' |
                                                | | | (_| | | | | | | (_| |
                                                |_|_|\__,_|_| |_| |_|\__,_|                                                                                                              
    ----------------------------------------------------------------------------------------------------------------------------                                                                                                                       
                                                                                                  ░░██        ░░    
                                                                                                ██████    ██▓▓██    
                                                                                              ████████▓▓▓▓████      
                                                                                            ▒▒████████░░▒▒██        
                                                                                        ▒▒▒▒██████▒▒██░░▓▓          
                                                                                        ██░░████░░░░██████          
                                                                                      ██░░░░██░░░░████████          
                                                                                    ██░░░░████░░░░██░░░░████        
                                                                                  ████░░░░░░░░░░░░██░░░░░░████      
                                                                                ▓▓██░░░░░░░░░░░░██░░░░░░░░░░██▓▓    
                                                                                ██░░░░░░░░░░░░░░██░░░░░░░░░░░░██▓▓  
                                                                              ▓▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██  
                                                                              ██░░░░░░░░░░░░░░░░▓▓▓▓░░░░░░░░░░░░░░▒▒
                                                                              ██░░░░░░░░░░░░░░░░████░░░░░░░░░░░░▓▓██
                                                                              ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██
                                                                              ██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██
                                                                              ██░░░░░░░░░░░░████░░░░░░░░░░░░░░░░██  
                                                                              ██░░░░░░░░░░░░░░██████████████████    
                                                                              ██░░░░░░░░░░░░░░░░░░░░██              
                                                                              ██░░░░░░░░░░░░░░░░░░░░██              
                                                                              ██░░░░░░░░░░░░░░░░░░░░██              
                                                                              ██░░░░░░░░░░░░░░░░░░░░░░██            
                                                                              ██░░░░░░░░░░░░░░░░░░░░░░██            
                                                                              ██░░░░░░░░░░░░░░░░░░░░░░██            
                                                                              ██░░░░░░░░░░░░░░░░░░░░░░██            
                                                                              ██░░░░░░░░░░░░░░░░░░░░░░██            
                                                                              ██░░░░░░░░░░░░░░░░░░░░░░░░██          
    ▓▓▓▓▓▓▓▓▓▓▓▓██                                                            ██░░░░░░░░░░░░░░░░░░░░░░░░██          
  ████░░░░░░░░░░██            ██████████████████████████                      ██    ░░░░░░░░░░░░░░░░░░░░██          
  ██░░░░░░░░░░░░██▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒              ██    ░░░░░░░░░░░░░░░░░░░░██          
  ██░░░░░░░░░░░░██                                            ██████        ████      ░░░░░░░░░░░░░░░░░░██          
  ██░░░░░░░░░░░░██                                                  ██████████        ░░░░░░░░░░░░░░░░░░██          
  ██░░░░░░░░░░░░░░                                                                      ░░░░░░░░░░░░░░░░██          
  ████░░██░░░░░░░░░░                                                                      ░░░░░░░░░░░░░░██          
      ████░░░░░░░░░░░░░░                                                                  ░░░░░░░░░░░░░░██          
        ████░░░░░░░░░░░░░░                                                                  ░░░░░░░░░░░░██          
          ██░░░░░░░░░░░░░░░░                                                                  ░░░░░░░░░░██          
          ████░░░░░░░░░░░░░░                                                                  ░░░░░░░░░░██          
            ██░░░░░░░░░░░░░░                                                                    ░░░░░░████          
            ██░░░░░░░░░░░░░░░░                                                                  ░░░░░░██            
            ██░░░░░░░░░░░░░░░░░░                                                                ░░░░░░██            
            ████░░░░░░░░░░░░░░░░                                                                ░░░░████            
              ██░░░░░░░░░░░░░░░░░░                                                              ░░██████            
              ██░░░░░░░░░░░░░░░░░░                                                              ████░░██            
              ██░░░░░░░░░░░░░░░░░░                                                            ██████░░██            
                ██░░░░░░░░░░░░░░░░░░                  ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                        ░░██░░██            
                ██░░░░░░░░░░░░░░░░░░              ▓▓▓▓████░░░░░░░░░░  ██▓▓                        ██░░██            
                ████░░░░░░░░░░░░░░░░░░          ████░░██                  ██                    ████████            
                  ██░░░░░░░░░░░░░░░░░░        ████░░████                    ██                  ██░░██              
                  ██░░░░░░░░░░░░░░░░░░        ██░░████                      ████                ██░░██              
                    ██░░░░░░░░░░░░░░░░    ████░░░░██                          ██                ██░░██              
                    ██░░░░░░░░░░░░░░░░░░  ██░░░░████                            ▓▓              ██░░██              
                    ██░░░░░░░░░░░░░░░░░░████░░▓▓██                              ██              ██░░██              
                    ██░░░░░░░░░░░░░░░░░░██░░░░██                                ██              ██░░██              
                    ░░▓▓░░░░░░░░░░░░░░████░░▓▓██                                ░░▓▓            ████░░              
                      ██░░░░░░░░░░░░░░██░░░░██                                    ██          ██████                
                      ██░░░░░░░░░░░░████░░░░██                                    ████        ██░░██                
                      ██░░░░░░░░░░░░██░░░░██                                        ██        ██░░██                
                      ██░░░░░░░░░░████░░░░██                                        ██        ██░░██                
                      ██░░░░░░░░████░░░░██                                          ██        ██░░██                
                      ██░░░░░░░░████░░░░██                                          ████    ████████                
                      ██░░░░░░▓▓  ██░░▓▓                                              ██    ██  ████                
                      ██▓▓░░░░██  ████                                                ██    ██                      
                        ██░░░░██  ██                                                  ██▓▓▓▓██                      
                        ██░░████  ██                                                  ░░████                        
                        ██▓▓██    ░░                                                    ░░░░   "

}

test(){
  banner

for f in $files; do
  printf "\n************************* BEGIN              *************************\n\n"
  printf "FILENAME $f\n"
  printf "\n"
  printf "************************* AST      PRINT OUT *************************\n\n"
  Run "cat" "$f" "|" "$TESTONE"
  printf "\n"
  printf "************************* SEMANT   PRINT OUT *************************\n\n"
  Run "cat" "$f" "|" "$TESTTWO"
  printf "\n"
  printf "************************* IRGEN    PRINT OUT *************************\n\n"
  Run "$LLAMA" "-c" "$f" ">" "${f%.*}.llama"
  Run "cat" ${f%.*}.llama
  printf "\n"
  printf "************************* CODE     PRINT OUT *************************\n\n"
  Run "$LLI" "${f%.*}.llama" ">" "${f%.*}.output"
  Run "$LLI" "${f%.*}.llama"
  printf "\n"
  printf "************************* EXPECTED PRINT OUT *************************\n\n"
  Run "cat" ${f%.*}.expected
  printf "\n\n"
  printf "************************* END                *************************\n\n"
done
}

testfail(){
for f in $files; do
  printf "\n************************* BEGIN              *************************\n\n"
  printf "FILENAME $f\n"
  printf "\n"
  printf "************************* AST      PRINT OUT *************************\n\n"
  Run "cat" "$f" "|" "$TESTONE"
  printf "\n"
  printf "************************* SEMANT   PRINT OUT *************************\n\n"
  Run "cat" "$f" "|" "$TESTTWO"
  printf "\n"
  printf "************************* IRGEN    PRINT OUT *************************\n\n"
  Run "$LLAMA" "-c" "<" "$f" "2>" "${f%.*}.err"
  Run "cat" ${f%.*}.err
  printf "\n"
  printf "************************* EXPECTED PRINT OUT *************************\n\n"
  Run "cat" ${f%.*}.expected
  printf "\n\n"
  printf "************************* END                *************************\n\n"
done
}
clean() {
	  find ./ -name "*.llama" | xargs rm
	  find ./ -name "*.output" | xargs rm
	  find ./ -name "*.err" | xargs rm
}
if [ ! -f "$LLAMA" ]; then
    make
fi
if [ ! -f "$TESTONE" ]; then
    make
fi
if [ ! -f "$TESTTWO" ]; then
    make
fi
if [ "$1" == "" ];  then
  Usage
fi
interactive=
while [ "$1" != "" ]; do
    case $1 in
        -a | --all )
                                files=`find $ALL -name '*.ll'`
                                test
                                files=`find $FAILURES -name '*.ll'`
                                testfail
                                ;;
        -f | --file )           shift
                                files="$1"
                                echo $files
                                test
                                ;;
        --prim )
                                files=`find $PRIMITIVES -name '*.ll'`
                                test
                                ;;
        --cont )
                                files=`find $CONTROL -name '*.ll'`
                                test
                                ;;
        --func )
                                files=`find $FUNCTIONS -name '*.ll'`
                                test
                                ;;
        --fail )
                                files=`find $FAILURES -name '*.ll'`
                                testfail
                                ;;
        --clean )
                                clean
                                exit
                                ;;
        -i | --interactive )
                                interactive=1
                                ;;
        -h | --help )           Usage
                                exit
                                ;;
        * )                     Usage
                                exit 1
    esac
    shift
done

if [ "$interactive" == "1" ]; then
  echo "interactive is on"
else
  echo "interactive is off"
fi

while [ "$interactive" = "1" ]; do

    echo -n "Enter [file path] to be tested or hit enter to exit : "
    read -r response
    if [ -n "$response" ]; then
          files="$response"
          test
    else 
      exit
    fi
done
