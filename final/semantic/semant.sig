signature Semantic =
sig
	type frag 
  val transProg : Absyn.exp -> frag list
end
