import Nat8 "mo:base/Nat8";
import Nat "mo:base/Nat";

actor {

    public func nat_to_nat8(n: Nat) : async Nat8 {
        return (Nat8.fromNat(n));
    };

    public func max_number_with_n_bits(n: Nat) : async Nat {
        return 2**n;
    };

    public func decimal_to_bits(num : Nat) : async Text {
        
        var text: Text = "";
        var n = num;
        while (n > 0) {
            text := Nat.toText(n % 2) # text;
            n := n / 2;
        };
        return text;
    };

};
