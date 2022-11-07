=begin

input: string which may include spaces and hyphens (encrypted name), some letters uppercase
output: decrypted name string, with spaces and hyphens preserved, casing preserved

high level algorithm:

1. iterate through array of names
2. for each name, break string into chars
3. iterate through each char, swapping with paired letter if applicable (skip non-letter chars)
4. rejoin name string, add to results array
5. output results

algorithm:

init empty results array
iterate through input array
  for each name, create empty array for decrypted name
    break into chars and iterate through chars
    if char is a-zA-Z
      use hash constant for decoding, swapping out chars
      if letter was uppercase, upcase new char
    add char to decrypted name array
  join and add decrypted name to output array
return output array

create encoding array by iterating through a..z (index values 0-25)
  to find encoded pair, find index value of current char + 13, % 25 => (new index value)

=end

def rot13(arr_of_names)
  alphabet = ('a'..'z').map { |letter| letter }

  results = []

  arr_of_names.each do |encrypted_name|
    decrypted_chars = []
    
    encrypted_name.chars.each do |old_char|
      if old_char.match(/[a-zA-Z]/)
        index = alphabet.index(old_char.downcase)
        new_index = (index + 13) % 26
        decrypted_char = alphabet[new_index]
      else
        decrypted_char = old_char
      end

      if old_char.match(/[A-Z]/)
        decrypted_chars << decrypted_char.upcase
      else
        decrypted_chars << decrypted_char
      end
    end

    results << decrypted_chars.join
  end

  puts results
end

list_of_pioneers = [
  'Nqn Ybirynpr',
  'Tenpr Ubccre',
  'Nqryr Tbyqfgvar',
  'Nyna Ghevat',
  'Puneyrf Onoontr',
  'Noqhyynu Zhunzznq ova Zhfn ny-Xujnevmzv',
  'Wbua Ngnanfbss',
  'Ybvf Unvog',
  'Pynhqr Funaaba',
  'Fgrir Wbof',
  'Ovyy Tngrf',
  'Gvz Orearef-Yrr',
  'Fgrir Jbmavnx',
  'Xbaenq Mhfr',
  'Fve Nagbal Ubner',
  'Zneiva Zvafxl',
  'Lhxvuveb Zngfhzbgb',
  'Unllvz Fybavzfxv',
  'Tregehqr Oynapu'
]

rot13(list_of_pioneers)
