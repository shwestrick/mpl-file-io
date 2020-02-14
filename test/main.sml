val path = List.hd (CommandLine.arguments ())
val t0 = Time.now ()
val contents = File.read path
val t1 = Time.now ()
val _ = print ("read file in " ^ Time.fmt 4 (Time.- (t1, t0)) ^ "\n")

(* val _ =
  Word8Array.app (fn word =>
    TextIO.output1 (TextIO.stdOut, Char.chr (Word8.toInt word)))
  contents *)
