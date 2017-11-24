require 'rspec'
require 'pry'
class Array
  def presence
    self == [] ? false : self
  end
end

def main(input_line)
  ps = '135798642'.split('').map.with_index(0) { |c, i| {c: c, p: nil, idx: i} }
  find_bs = ->(p) { [p, [ps[p[:idx] - 1], ps[(p[:idx] + 1) % 9  ]]] }
  input_line.chomp.split('').each do |input|
    if ('A'.."Z").include?(input)
      emptys_by_3 = ps.select{ |p| p[:p].nil? }.map(&find_bs).map.with_object([[], [], []]) do |pb, ob|
        case pb.last.select { |p| p[:p].nil? }.count
        when 2
          ob[0].push pb.first
        when 1
          ob[1].push pb.first
        else
          ob[2].push pb.first
        end
      end
      emptys = (emptys_by_3[0].presence || emptys_by_3[1].presence || emptys_by_3[2].presence).sort_by{|p|p[:c]}
      if ('A'.."M").include?(input)
        emptys.first[:p] = input
      else
        emptys.last[:p] = input
      end
    else
      ps.find { |p| p[:p] == input.upcase }[:p] = nil
    end
  end
  ps.map{|p| p[:p] || '-'}.join
end

if __FILE__ == $0
  puts main(gets)
end

RSpec.describe do
  it { expect(main "NABETanI").to eq ("I-E--T-B-")  }
  it { expect(main "A").to eq ("A--------")  }
  it { expect(main "Aa").to eq ("---------")  }
  it { expect(main "Z").to eq ("----Z----")  }
  it { expect(main "Zz").to eq ("---------")  }
  it { expect(main "AaB").to eq ("B--------")  }
  it { expect(main "ABa").to eq ("-------B-")  }
  it { expect(main "ABCDEFGHI").to eq ("AGCEIDHBF")  }
  it { expect(main "OPQRSTUVW").to eq ("WSQUOTPVR")  }
  it { expect(main "F").to eq ("F--------")  }
  it { expect(main "L").to eq ("L--------")  }
  it { expect(main "Mm").to eq ("---------")  }
  it { expect(main "JQ").to eq ("J---Q----")  }
  it { expect(main "ACP").to eq ("A---P--C-")  }
  it { expect(main "GgS").to eq ("----S----")  }
  it { expect(main "USLE").to eq ("L-E-U-S--")  }
  it { expect(main "XJZY").to eq ("J-Y-X-Z--")  }
  it { expect(main "NnJXx").to eq ("J--------")  }
  it { expect(main "AJjQa").to eq ("----Q----")  }
  it { expect(main "HGThgQ").to eq ("----T-Q--")  }
  it { expect(main "NJRErI").to eq ("J-E-N--I-")  }
  it { expect(main "ZzWwDYG").to eq ("D---Y--G-")  }
  it { expect(main "ZGgKQHM").to eq ("K-H-Z-Q-M")  }
  it { expect(main "OZYSAsHP").to eq ("A-Y-OPZ-H")  }
  it { expect(main "VNnEISAW").to eq ("E-S-VWAI-")  }
  it { expect(main "HhYAKkCOE").to eq ("A-O-Y-EC-")  }
  it { expect(main "KAkHJTSWV").to eq ("H-JWTSVA-")  }
  it { expect(main "WNTYKHZhMQ").to eq ("KMTQWZN-Y")  }
  it { expect(main "YyJHFGfgTh").to eq ("J---T----")  }
  it { expect(main "NRWPLBZAOpC").to eq ("LBWONZRAC")  }
  it { expect(main "IORiTMXHUCF").to eq ("MCTFOURXH")  }
  it { expect(main "AEeHGBEJUNZn").to eq ("AZGEUB-HJ")  }
  it { expect(main "GgKGSOsZTLYS").to eq ("K-OYZTSGL")  }
  it { expect(main "VZvPOpWPMzHGF").to eq ("MGO-W-HFP")  }
  it { expect(main "CMmcUuLTWADFQ").to eq ("LFA-TQW-D")  }
  it { expect(main "HUGZMLzlNgTLDd").to eq ("H-N-U-MTL")  }
  it { expect(main "CFKEkHeJShUDTf").to eq ("C-UTSJ--D")  }
  it { expect(main "QJjGPMAICHKqWcY").to eq ("GIMHWKPYA")  }
  it { expect(main "HhIiQCIBiUMZcVv").to eq ("--B-QZU-M")  }
  it { expect(main "VMvEmFOPANIBUiVb").to eq ("F-PUONAEV")  }
  it { expect(main "EDCJUINdLPVnFpGe").to eq ("-VCFUJGLI")  }
  it { expect(main "FGQINTEnLMAlBbPpV").to eq ("FMITQAVGE")  }
  it { expect(main "WSVCORUMXsvNBuTtT").to eq ("CXBTWRNOM")  }
  it { expect(main "HJTjRVIQAXqDGxCtUh").to eq ("-AVCUGRDI") }
  it { expect(main "ZzHXIEKQYUuBTxLlCq").to eq ("HTEYC-KIB") }
  it { expect(main "RGDCAEBVrgFbTJUePjc").to eq ("-T-FUVADP") }
  it { expect(main "WBIRSALCVvsbwalYBJP").to eq ("B-R-YPCIJ") }
  it { expect(main "HKFZGEPAIphLRarAOaHo").to eq ("LHFIZ-GKE") }
  it { expect(main "WFNwBfbSAXCZzMDJUcKx").to eq ("AM-JSUNDK") }
end
