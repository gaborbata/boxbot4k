#!/usr/bin/env ruby

# Experimental compression methods for BoxBot4k game data
#
# Copyright (c) 2014 Gabor Bata
#
# Permission is hereby granted, free of charge, to any person
# obtaining a copy of this software and associated documentation files
# (the "Software"), to deal in the Software without restriction,
# including without limitation the rights to use, copy, modify, merge,
# publish, distribute, sublicense, and/or sell copies of the Software,
# and to permit persons to whom the Software is furnished to do so,
# subject to the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
# BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
# ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
# CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

LEVEL_DATA =
  '              ' +
  '              ' +
  '              ' +
  '   ####       ' +
  '   #"!#       ' +
  '   #!!#####   ' +
  '   #%!!%!!#   ' +
  '   #!$!!!"#   ' +
  '   ########   ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    ####      ' +
  '    #!!###    ' +
  '    #!!%$#    ' +
  '    #!&"!#    ' +
  '    ##!!!#    ' +
  '     #####    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    ####      ' +
  '    #!!#      ' +
  '    #!!###    ' +
  '    #!!%!#    ' +
  '    ##&#"#    ' +
  '    #!!$!#    ' +
  '    #!!!!#    ' +
  '    #!!###    ' +
  '    ####      ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    ####      ' +
  '    #!!#      ' +
  '    #!!#      ' +
  '    #!$###    ' +
  '    #!%%!#    ' +
  '    #"!!"#    ' +
  '    ######    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    #####     ' +
  '    #!!!#     ' +
  '    #"#%##    ' +
  '    #!!$!#    ' +
  '    #"!%!#    ' +
  '    ###!!#    ' +
  '      ####    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '   ########   ' +
  '   #!!!!!!#   ' +
  '   #!"&&%$#   ' +
  '   #!!!!!!#   ' +
  '   #####!!#   ' +
  '       ####   ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '      ####    ' +
  '    ###!!#    ' +
  '    #"%%"#    ' +
  '    #!#!!#    ' +
  '    #!$!!#    ' +
  '    ###!!#    ' +
  '      ####    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '     ####     ' +
  '   ###!!#     ' +
  '   #!!!!#     ' +
  '   #!!!"###   ' +
  '   ###!#$"#   ' +
  '     #!%%!#   ' +
  '     #!!%!#   ' +
  '     #"!###   ' +
  '     ####     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    ######    ' +
  '   ##!!!!#    ' +
  '   #!%##!##   ' +
  '   #!!!!!!#   ' +
  '   ##!!"$"#   ' +
  '    #%#!###   ' +
  '    #!!!#     ' +
  '    #####     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    ####      ' +
  '   ##!!####   ' +
  '   #!!!!!!#   ' +
  '   #!""#%!#   ' +
  '   ###!!%!#   ' +
  '     ###$!#   ' +
  '       ####   ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '      #####   ' +
  '      #!!!#   ' +
  '  #####!#!##  ' +
  '  #!!#!%!!!#  ' +
  '  #!!!%!!#!#  ' +
  '  #!""!#!!!#  ' +
  '  ###$!#####  ' +
  '    #!!#      ' +
  '    ####      ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    #####     ' +
  '    #!!!###   ' +
  '  ###$%"!!#   ' +
  '  #!!&#!!!#   ' +
  '  #!!!%"!##   ' +
  '  #####!!#    ' +
  '      ####    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '   ####       ' +
  '   #!!####    ' +
  '   #!"!!!#    ' +
  '   #!$%%!#    ' +
  '   ##!!###    ' +
  '    #"!#      ' +
  '    #!!#      ' +
  '    ####      ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    #####     ' +
  '   ##!!"#     ' +
  '   #!%#"#     ' +
  '   #!!!!##    ' +
  '   ##!#!!#    ' +
  '    #%!$!#    ' +
  '    #!!!##    ' +
  '    #####     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '      #####   ' +
  '      #!!!#   ' +
  '   ####!!!#   ' +
  '   #"&!!!##   ' +
  '   #!%#!!#    ' +
  '   #$!#!!#    ' +
  '   #######    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    ####      ' +
  '    #"$#      ' +
  '    #!!###    ' +
  '    #!%!!#    ' +
  '    #!%"!#    ' +
  '    #!!###    ' +
  '    ####      ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '     #####    ' +
  '   ###!!!#    ' +
  '   #!%!#!##   ' +
  '   #!#!!"!#   ' +
  '   #!"!!#!#   ' +
  '   ##%#"%!#   ' +
  '    #$!!###   ' +
  '    #####     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    #######   ' +
  '    #!!!!"#   ' +
  '    #!###"#   ' +
  '   ##!#!!!#   ' +
  '   #!!#!%!#   ' +
  '   #!!$!%##   ' +
  '   #!!#!!#    ' +
  '   #######    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    ####      ' +
  '  ###!!####   ' +
  '  #!!!!#$"#   ' +
  '  #!!!!%%"#   ' +
  '  #!!##!%"#   ' +
  '  #####!!!#   ' +
  '      #####   ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    #####     ' +
  '    #!$!###   ' +
  '    #!#!!!#   ' +
  '   ##%"&#!#   ' +
  '   #!%"&!!#   ' +
  '   #!#!!###   ' +
  '   #!!!!#     ' +
  '   ######     ' +
  '              ' +
  '              ' +
  '              ' +
  '   ####       ' +
  '   #!!#       ' +
  '   #%$#       ' +
  '   #"%###     ' +
  '  ##"%!!##    ' +
  '  #!"#!!!##   ' +
  '  #!!!!!!!#   ' +
  '  #####!!!#   ' +
  '      #####   ' +
  '              ' +
  '              ' +
  '              ' +
  '   ####       ' +
  '   #!!###     ' +
  '   #!$!!#     ' +
  '   #"!#%##    ' +
  '   ##"%!!#    ' +
  '   #!%"#!#    ' +
  '   #!#!!!#    ' +
  '   #!!!!##    ' +
  '   ###!!#     ' +
  '     ####     ' +
  '              ' +
  '              ' +
  '              ' +
  '   #######    ' +
  '  ##!!#!!###  ' +
  '  #!%!#!%!!#  ' +
  '  #!!"$"!!!#  ' +
  '  ##%!#!%###  ' +
  '   #!"!"!#    ' +
  '   #######    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '   ####       ' +
  '   #!!#####   ' +
  '   #!!"&"!#   ' +
  '   #!%!%!$#   ' +
  '   #!!!####   ' +
  '   #####      ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '   #######    ' +
  '   #"!"!"#    ' +
  '   #!!!#!#    ' +
  '   ##!!%!#    ' +
  '    #!%%##    ' +
  '    #!!$#     ' +
  '    #####     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    ####      ' +
  '    #!!##     ' +
  '   ##!!!##    ' +
  '   #!$%%!#    ' +
  '   #!#!#!#    ' +
  '   #""!!!#    ' +
  '   #######    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '     ####     ' +
  '     #!"#     ' +
  '   ###!!##    ' +
  '   #!%%!!#    ' +
  '   #!!!!!#    ' +
  '   ##%#!##    ' +
  '    #"$"#     ' +
  '    #####     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '     #####    ' +
  '     #!!!#    ' +
  '   ###%#!##   ' +
  '   #!!%$%!#   ' +
  '   #!#!!!!#   ' +
  '   #"""!###   ' +
  '   ######     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '  ######      ' +
  '  #!!!!#      ' +
  '  #!!"%#####  ' +
  '  ##&"%!!!!#  ' +
  '   #$"%#!!!#  ' +
  '   ##!!#####  ' +
  '    ####      ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    #######   ' +
  '   ##!"!!!#   ' +
  '   #!%&%#!#   ' +
  '   #!#$!!!#   ' +
  '   #!!"!###   ' +
  '   ######     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '   #######    ' +
  '  ##""""$##   ' +
  '  #!!%!#%!#   ' +
  '  #!!%!!%!#   ' +
  '  #!!##!!!#   ' +
  '  #########   ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '      ####    ' +
  '   ####!$#    ' +
  '   #!!%%!#    ' +
  '   #!"!%!#    ' +
  '   ##""!##    ' +
  '    #####     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '   ########   ' +
  '   #!"$"!!#   ' +
  '   #!%!%!!#   ' +
  '   ##&#&###   ' +
  '   #!!!!!#    ' +
  '   #!!!!!#    ' +
  '   #!!####    ' +
  '   ####       ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '   #######    ' +
  '   #!"!!!#    ' +
  '   #!!%""#    ' +
  '   ###%&###   ' +
  '   #!%$!!!#   ' +
  '   #!!!!!!#   ' +
  '   ########   ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '     ####     ' +
  '   ###!!#     ' +
  '   #!!!!##    ' +
  '   #!#!""#    ' +
  '   #!%%%$#    ' +
  '   ###!#!#    ' +
  '     #!!"#    ' +
  '     #####    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '     #####    ' +
  '   ###!!!#    ' +
  '   #!%%%$#    ' +
  '   #"""!##    ' +
  '   #!!!!#     ' +
  '   ######     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '     #####    ' +
  '    ##!!!#    ' +
  '    #!$!!#    ' +
  '   ##!%!##    ' +
  '   #!%&!#     ' +
  '   #!#"!#     ' +
  '   #!!"##     ' +
  '   #####      ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '     ####     ' +
  '     #!!#     ' +
  '   ###%!##    ' +
  '   #!!%!!#    ' +
  '   #$#&"!##   ' +
  '   #!!&"!!#   ' +
  '   ###!!!!#   ' +
  '     ######   ' +
  '              ' +
  '              ' +
  '              ' +
  '      #####   ' +
  '    ###$!!#   ' +
  '    #"!%!"#   ' +
  '    #!!%!##   ' +
  '   ###!###    ' +
  '  ##!%!!#     ' +
  '  #!!!!!#     ' +
  '  #"!!###     ' +
  '  #####       ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    ####      ' +
  '    #!!##     ' +
  '    #$"!#     ' +
  '    #""%##    ' +
  '    #!%%!#    ' +
  '    #!!!!#    ' +
  '    ######    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '     ####     ' +
  '     #!!###   ' +
  '   ###!"!!#   ' +
  '   #$%%%!!#   ' +
  '   #!!!#"!#   ' +
  '   ###"!!##   ' +
  '     #####    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    ####      ' +
  '    #!!#      ' +
  '    #!!####   ' +
  '    #!""&!#   ' +
  '   ##!%%$!#   ' +
  '   #!!!####   ' +
  '   #!!!#      ' +
  '   #####      ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '  #####       ' +
  '  #!!!###     ' +
  '  #!!"%!###   ' +
  '  ##!"#!%!#   ' +
  '   #!"#!%$#   ' +
  '   ##"!!%!#   ' +
  '    #!!####   ' +
  '    ####      ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '  ####        ' +
  '  #!!#####    ' +
  '  #!!!!$!##   ' +
  '  #!"&"%&!#   ' +
  '  ##!!#%!!#   ' +
  '   ##!!!###   ' +
  '    #####     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '      ####    ' +
  '  #####!!#    ' +
  '  #!!!""%##   ' +
  '  #!%$#!%!#   ' +
  '  ##%""!!!#   ' +
  '   #!!##!!#   ' +
  '   ########   ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    #####     ' +
  '    #!!!#     ' +
  '    #!#%##    ' +
  '   ##""$!#    ' +
  '   #!&"%!#    ' +
  '   #!#!%##    ' +
  '   #!!!!#     ' +
  '   ######     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '  ###         ' +
  '  #"#####     ' +
  '  #"""!!#     ' +
  '  #!#!#!###   ' +
  '  #!!!%%!$#   ' +
  '  ###!!%%!#   ' +
  '    ###!!!#   ' +
  '      #####   ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '   ########   ' +
  '   #!!##!"#   ' +
  '  ##!!!%!!#   ' +
  '  #!!%#%!"#   ' +
  '  #!!!#$!##   ' +
  '  #"!##!!#    ' +
  '  ########    ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '    #####     ' +
  '    #!!!#     ' +
  '   ##!!!###   ' +
  '   #!%%%%!#   ' +
  '   #!""""!#   ' +
  '   ##!$!###   ' +
  '    #####     ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '              ' +
  '  ########    ' +
  '  #""!$""#    ' +
  '  #!!%%%!#    ' +
  '  ####!####   ' +
  '  #!!!!!!!#   ' +
  '  #!!!!!%!#   ' +
  '  #!!######   ' +
  '  ####        ' +
  '              ' +
  '              '

IMAGE_DATA =
  '     !!!!!"     ' +
  '     !"!"!"     ' +
  '     !!!!!"     ' +
  '     !"""!"     ' +
  '     !!!!!"     ' +
  '     """"""     ' +
  '  !"!!!!!!!"!"  ' +
  '  !"!!!!!!!"!"  ' +
  '  !"!"""""!"!"  ' +
  '  !"!"""""!"!"  ' +
  '  ""!!!!!!!"""  ' +
  '    """"""""    ' +
  '     !"  !"     ' +
  '     !"  !"     ' +
  '   !!!"  !!!"   ' +
  '   """"  """"   ' +
  '               "' +
  ' !!""!!!!!!""!!"' +
  ' !!  !!!!!!  !!"' +
  '""""""""""""""""' +
  '   "   "   "   "' +
  ' !!" !!" !!" !!"' +
  ' !!" !!" !!" !!"' +
  ' !!" !!" !!" !!"' +
  ' !!" !!" !!" !!"' +
  ' !!" !!" !!" !!"' +
  ' !!" !!" !!" !!"' +
  '""""""""""""""""' +
  '               "' +
  ' !!""!!!!!!""!!"' +
  ' !!  !!!!!!  !!"' +
  '""""""""""""""""' +
  '        !!!!!!!!' +
  ' """""" !      !' +
  ' """""" !      !' +
  ' """""" !      !' +
  ' """""" !      !' +
  ' """""" !      !' +
  ' """""" !      !' +
  '        !!!!!!!!' +
  '!!!!!!!!        ' +
  '!      ! """""" ' +
  '!      ! """""" ' +
  '!      ! """""" ' +
  '!      ! """""" ' +
  '!      ! """""" ' +
  '!      ! """""" ' +
  '!!!!!!!!        ' +
  ' !!!!!!!!!  !!! ' +
  '!!!       "!!! "' +
  '!!       ""!!  "' +
  '!       """!   "' +
  ' """"""""" !   "' +
  ' !!!  !!!! !   "' +
  '!!! "!!!  "!   "' +
  '!!  "!!   "!   "' +
  '!   "!   ""!  ""' +
  '!   "!  """! """' +
  '!   " """"  """ ' +
  '!   " !!!!!!!!! ' +
  '!   "!!!       "' +
  '!  ""!!       ""' +
  '! """!       """' +
  ' """  """"""""" '

TEXTS = 'LEVEL COMPLETED! PRESS ENTER TO CONTINUE.,BOXBOT4K,,GAME CONTROLS:,ARROW KEYS - MOVE,BACKSPACE - RESTART LEVEL,' +
        'PGUP/PGDN - NEXT/PREVIOUS LEVEL,,PRESS ANY KEY TO START.,(C) 2014 GABOR BATA,     ,LEVEL: ,MOVES: ,PUSHES: '

# RLE compression
#
# RLE stands for Run Length Encoding. It is a lossless algorithm that only offers decent compression ratios in specific types of data.
# It replaces sequences of the same data values within a file by a count number and a single value.
#
# Input: ascii string (0x20-0x26: data, >= 0x27: repetition marker)
# Symbols used in input: OUTER_FLOOR = 0; FLOOR = 1; GOAL = 2; WALL = 3; PLAYER = 4; BOX = 5; BOX_ON_GOAL = 6;
def rle_compress(input)
  shift = 0x20
  compressed = ''
  char_array = (input + '/').split('')
  init = char_array[0]
  chars = []
  char_array.each do |c|
    if (c == init && chars.size() <= 88)
      chars.push(c)
    else
      if (chars.size() > 2)
        compressed << ((chars.size() + shift + 5).chr) << (chars[0])
      else
        chars.each do |ch|
          compressed << ch
        end
      end
      chars = []
      init = c
      chars.push(c)
    end
  end
  return compressed
end

def rle_decompress(input)
  decompressed = ''
  repeat = 1
  input.split('').each do |c|
    if (c.ord >= 0x27)
      repeat = c.ord - 0x25
    else
      (0 ... repeat).to_a.each do |i|
        decompressed << c
      end
      repeat = 1
    end
  end
  return decompressed
end

def decompress(input)
  entries = input.split('|')
  decompressed = entries.shift
  (0 ... entries.size).to_a.each do |i|
    decompressed.gsub!(Regexp.new(entries[i][0]), entries[i][1 .. entries[i].size - 1])
  end
  return decompressed
end

def substitute_chars(input, unused_chars, subst_map)
  word_count = {}
  (2 .. 11).to_a.reverse.each do |word_length|
    input.scan(Regexp.new(".{#{word_length}}")).each do |word|
      word_count[word] = 0 if word_count[word].nil?
      word_count[word] += 1
    end
  end
  compressed_candidate = input
  compressed = input
  subst = nil
  word_count.each do |word, count|
    next if count < 3 || !compressed.include?(word) || unused_chars.empty?
    subst = unused_chars.shift if subst.nil?
    compressed_candidate = input.gsub(word, subst)
    if compressed_candidate.size < compressed.size
      compressed = compressed_candidate
      subst_map[subst] = word
    end
  end
  return compressed
end

# Pattern Substitution based compression
#
# Substitue a frequently repeating pattern(s) with a code. The code is shorter than pattern giving us compression.
# More typically tokens are assigned to according to frequency of occurrence of patterns.
def compress(input)
  unused_chars = []
  subst_characters = (' ' .. '~').to_a.reverse
  subst_characters.each do |char|
    # substitution characters must be safe from RegExp point of view
    next if ['|', '\\', '[', ']', '?', '+', '*', '(', ')', '.', '^', '\'', '$', '{', '}'].include?(char)
    unused_chars.push(char) if !input.include?(char)
  end
  subst_map = {}
  compressed = input
  prev_compressed = ''
  while (unused_chars.size > 0) do
    prev_compressed = compressed
    compressed = substitute_chars(compressed, unused_chars, subst_map)
    break if prev_compressed == compressed
  end
  subst_map.keys.reverse.each do |char|
    compressed << "|#{char}#{subst_map[char]}"
  end
  return compressed
end

def test(name, data)
  compressed = compress(data)
  decompressed = decompress(compressed)
  puts "================================================="
  puts name
  puts "-------------------------------------------------"
  puts "input data size ........ [#{data.size} bytes]"
  puts "compressed size (RLE) .. [#{(rle_compress(data)).size} bytes]"
  puts "compressed size (sub) .. [#{compressed.size} bytes]"
  puts "compression ratio ...... [#{sprintf('%.2f%', (1.0 - compressed.size.to_f / data.size.to_f) * 100.0)}]"
  puts "decompression valid .... [#{data == decompressed}]"
  puts "-------------------------------------------------"
  puts "compressed = '#{compressed}';"
  puts "================================================="
  puts
end

test("levels", LEVEL_DATA)
test("images", IMAGE_DATA)
test("texts", TEXTS)
