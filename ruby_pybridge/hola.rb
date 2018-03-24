while cmd = STDIN.gets
  cmd.chop!
  if cmd == "exit"
    break
  else
    print eval(cmd),"\n"
    print "[end]\n"
    STDOUT.flush
  end
end
