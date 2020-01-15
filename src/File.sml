structure File :>
sig
  val read: string -> char array
end =
struct

  val parfor = ForkJoin.parfor
  val par = ForkJoin.par
  val alloc = ForkJoin.alloc



  fun read path =
    let
      open Poxis.FileSys
      val file = openf (path, O_RDONLY, O.fromWord 0w0)
    in
      alloc 0
    end

    (*
  fun readString path =
    let
      val bytes = read path
    in
      CharVector.tabulate (Array.length bytes, fn i =>
        Char.chr (Word8.toInt (Array.sub (bytes, i))))
    end
     *)

end
