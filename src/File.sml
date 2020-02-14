structure File :>
sig
  val read: string -> Word8Array.array
end =
struct

  val parfor = ForkJoin.parfor
  val par = ForkJoin.par
  val alloc = ForkJoin.alloc

  fun read path =
    let

      val (file, length) =
        let
          open Posix.FileSys
          val file = openf (path, O_RDONLY, O.nonblock)
        in
          (file, Position.toInt (ST.size (fstat file)))
        end

      val _ = print (Int.toString length ^ "\n")

      open Posix.IO
      (* val length = Position.toInt (ST.size (fstat file)) *)
      (* val length = Position.toInt (lseek (file, 0, SEEK_END)) *)
      (* val _ = lseek (file, 0, SEEK_SET) *)
      val result = Word8ArrayExtra.alloc length

      fun dumpSeq (i, j) =
        let
          val file' = dup file
        in
          lseek (file', Position.fromInt i, SEEK_SET);
          readArr (file', Word8ArraySlice.slice (result, i, SOME (j-i)));
          close file'
        end

      fun dump (i, j) =
        if j-i <= 100000 then
          dumpSeq (i, j)
        else
          (par (fn _ => dump (i, i + (j-i) div 2),
                fn _ => dump (i + (j-i) div 2, j));
           ())
    in
      dump (0, length);
      close file;
      result
    end

end
