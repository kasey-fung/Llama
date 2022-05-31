all:
	ocamlbuild test1.native
	ocamlbuild test2.native
	ocamlbuild -use-ocamlfind llama.native -package llvm,llvm.analysis,str


yacc:
	ocamlyacc -v parser.mly

clean:
	ocamlbuild -clean
	rm -fr *.cmi *.cmo parser.ml parser.mli lexer.ml parser.output
testclean:
	./testingllama.sh --clean