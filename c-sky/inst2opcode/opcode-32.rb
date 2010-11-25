def trim(s)
  s.gsub(/[\W]+/,"")
end

opcodes={}
opcode=""
previous_line=""
start_flag=false
yufa_flag = false
cur_inst=""
File.open("inst.txt").each_line do |x| 
 if yufa_flag
  cur_inst = x
  yufa_flag = false
 end
 if start_flag
  opcode << trim(x)
 end
 if trim(x)=="0" && trim(previous_line)==""
   start_flag=true 
   opcode = "0"
 end
 if trim(x)=="" and start_flag
  start_flag=false  
  opcodes[cur_inst]=opcode
  opcode = ""
 end
 yufa_flag = true if x[0,5] == "yufa:"
 previous_line=x
end

File.open("opcode32.txt","w") do |f|
  opcodes.sort.each {|x| f << x[0]+"\t" + x[1] +"\r\n"}
end

