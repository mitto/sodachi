#!/usr/bin/env ruby

require 'romkan'

def debug?
  ENV["DEBUG"] || false
end

dic = ("a".."z").to_a
encrypted = <<EOL
2621202015 230111012020052001
111520150201 = 211915020111011809
11011420011414092301192118051821 06212001190809110104050109130109140113151415

1908091410092019211315140510090621190520051121
13010815211409140907051115140405

200109251521131511090520011401201921
11809110918090405 230120011908090701
13090308090209110904011908092001 1115200105

=
110913090401202001
1309201921110520011415

04011805251518091315 2001040119080909080126211415 11152001052315

1109200109190809200102211404011105
230118091109180514011121140111211401202005
0215112118011409 012005080113011821 11152119080911092315190107011908092005092001

110913090701 140505 2301180109110111051821040111050405 131521
21180519080911212005

200109251521131511090520011401201921
11809110918090405 230120011908090701
13090308090209110904011908092001 1115200105

=
110913090401202001
1309201921110520011415

04011805251518091315 2001040119080909080126211415 11152001052315

10090221140405 030801142015 1301030809070123011401092015
09201921130104050401202005 230111011801140111212005
2001202001 080920152019211415211915040525151101202001
1109130914152119151409 151908092001151901180520011101202001

130108152107012015110518211301051409
131521 1041504011105 23011801202005

200109251521131511090520011401201921
11809110918090405 230120011908090701
13090308090209110904011908092001 1115200105

=
110913090401202001
1309201921110520011415

1309201921110520012015
1513152020011415

04011805251518091315 2001040119080909080126211415 11152001052315
EOL

encrypted.each_line do |line|
  line.chomp!
  if line == "="
    print "=\t" if debug?
    print "それは"
  else
    line_splitted = line.split
    line_splitted.each do |space_splited_terms|
      if space_splited_terms == "="
        print "=\t" if debug?
        print "は"
      else
        sliced = space_splited_terms.slice!(0) if space_splited_terms.size.odd?
        numbered = space_splited_terms.split(//).each_slice(2).map{|c| c.join.to_i}
        romaed = numbered.map{|c| dic[c - 1]}.join.gsub("nn", "nnn") # [ん]まわり調整
        if debug?
          # 数字出力
          print "%02d " % sliced if sliced
          print "#{numbered.map{|i| "%02d" % i}.join(" ")}\t"
          # ローマ字出力
          print sliced if sliced
          print "#{romaed}\t"
        end
        # ひらがな出力
        print sliced if sliced
        print romaed.to_kana
      end
      if line_splitted.last != space_splited_terms
        print " "
        puts if debug?
      end
    end
  end
  puts
end
