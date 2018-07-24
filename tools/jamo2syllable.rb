#!/usr/bin/ruby
#Idea taken from: https://en.wikipedia.org/wiki/Korean_language_and_computers#Hangul_in_Unicode

def generateSyllableCode(initial, medial, final = 0)
    return (initial * 588) + (medial * 28) + final + 44032
end

def code2utf8(code)
    return [code].pack('U')
end

def generateSyllable(initial, medial, final)
    return code2utf8(generateSyllableCode(initial, medial, final))
end

def composeSyllable(initial, medial, final)
    jamos = [initial, medial, final]
        .map{|decimalShift| decimalShift.to_s(16)}
        .zip(%w(1100 1161 11A7))
        .map{|jamoShift,jamoStart| jamoShift.hex + jamoStart.hex}
        .map{|jamoCode| code2utf8(jamoCode)}
    jamos.pop if final == 0 # if not dropped creates a weird symbol
    return jamos
end

def generateThraxBody(initial, medial, final=0)
    generated = generateSyllable(initial, medial, final)
    composed = composeSyllable(initial, medial, final)
    return "\"#{generated}\" : (\"#{composed.join('" "')}\")"
end

def generateThraxRule(name, body)
    return "#{name} = Optimize[#{body}];"
end

def generateExportedThraxRule(name, body)
    return "export #{name} = Optimize[#{body}];"
end

initialRules = []
for initial in 0..18 do
    medialRules = []
    for medial in 0..20 do
        finalRules = []
        for final in 0..26 do
            ruleName = "I#{initial}M#{medial}F#{final}"
            puts generateThraxRule(ruleName, generateThraxBody(initial, medial, final))
            finalRules.push(ruleName)
        end
        ruleName = "I#{initial}M#{medial}F"
        puts generateExportedThraxRule(ruleName, finalRules.join(" | "))
        medialRules.push(ruleName)
    end
    ruleName = "I#{initial}MF"
    puts generateExportedThraxRule(ruleName, medialRules.join(" | "))
    initialRules.push(ruleName)
end
ruleName = "IMF"
puts generateExportedThraxRule(ruleName, initialRules.join(" | "))
puts generateExportedThraxRule("MAIN", ruleName)


