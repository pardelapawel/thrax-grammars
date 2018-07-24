def generateSyllableCode(initial, medial, final = 0)
    syllableCode = (initial * 588 + medial * 28 + final) + 44032
    #puts "init: #{initial} medial: #{medial} fin: #{final} = #{syllableCode}"
    return syllableCode
end

def code2utf8(code)
    return [code].pack('U')
end

def generateSyllable(initial, medial, final)
    return code2utf8(generateSyllableCode(initial, medial, final))
end

def to_16(number)
    return number.to_s(10).to_i(16)
end

def to_16_straight(number)
    return number.to_s(16).to_i(16)
end

def generateThraxLine(initial, medial, final=0)
    initHex = to_16_straight(initial) + to_16(1100)
    medHex = to_16_straight(medial) + to_16(1162)
    finHex = to_16_straight(final) + to_16("11A8".hex)
    return "var = (\"#{code2utf8(initHex)}\" \"#{code2utf8(medHex)}\" \"#{code2utf8(finHex)}\") : \"#{generateSyllable(initial, medial, final)}\""
end

#puts "한 is #{generateSyllableCode(18, 0, 4)} in unicode: #{generateSyllable(18, 0, 4)}"

#puts "\u1100"
#puts code2utf8(1100.to_s.to_i(16))

#__END__

medial = 0
final = 0
for initial in 0..18 do
    #for medial in 0..20 do
        #for final in 0..27 do
            puts generateThraxLine(initial, medial, final)
        end
#    end
#end


