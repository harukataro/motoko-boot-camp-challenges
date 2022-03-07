import Nat8 "mo:base/Nat8";
import Nat "mo:base/Nat";
import Text "mo:base/Text";
import Prim "mo:prim";
import Char "mo:base/Char";
import Array "mo:base/Array";
import Iter "mo:base/Iter";

actor {

    // Challenge 1
    public func nat_to_nat8(n: Nat) : async Nat8 {
        return (Nat8.fromNat(n));
    };

    // Challenge 2
    public func max_number_with_n_bits(n: Nat) : async Nat {
        return 2**n;
    };

    // Challenge 3
    public func decimal_to_bits(num : Nat) : async Text {
        
        var text: Text = "";
        var n = num;
        while (n > 0) {
            text := Nat.toText(n % 2) # text;
            n := n / 2;
        };
        return text;
    };

    // Challenge 4
    public func capitalize_character(c: Char) : async Char {
        let c_upper = Prim.charToUpper(c);
        return c_upper;
    };

    // Challenge 5
    public func capitalize_text(t: Text) : async Text {
        let t_upper = Text.map(t, Prim.charToUpper);
        return t_upper;
    };

    // Challenge 6
    public func is_inside(a: Text, c: Char) : async Bool {
        return Text.contains(a, #char c);
    };

    // Challenge 7
    public func trim_whitespace(t: Text) : async Text {
        return Text.trim(t, #char ' ');
    };

    // Challenge 8
    public func duplicated_characters(t: Text) : async Text {
        for(c in t.chars()) {
            var isFirst: Bool = true;
            for(c2 in t.chars()){
                if(Char.equal(c, c2)){
                    if(isFirst){
                        isFirst := false;
                    } else {
                        return Char.toText(c);
                    }
                }
            };
        };
        return t;
    };

    // Challenge 9
    public func size_in_byted(t: Text) : async Nat {
        return Text.size(t);
    };

    // Challenge 10
    public func bubble_sort(ar : [Nat]) : async [Nat] {
        let a: [var Nat] = Array.thaw<Nat>(ar);
        let a_idx_max = a.size() - 1;

        for (step in Iter.range(0, a_idx_max -1)) {
            for(i in Iter.range(0, a_idx_max - step -1)) {
                if(a[i] > a[i+1]) {
                    let tmp = a[i];
                    a[i] := a[i+1];
                    a[i+1] := tmp;
                }
            }
        };
        return Array.freeze<Nat>(a);
    };
};
