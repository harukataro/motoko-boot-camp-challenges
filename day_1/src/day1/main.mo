import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";

actor {

    stable var count = 0 :Nat;

    public func add(a : Nat, b : Nat) : async Nat {
        return a + b;
    };

    public func square(a : Nat) : async Nat {
        return a * a;
    };

    public func days_to_second(days : Nat) : async Nat {
        return days * 24 * 60 * 60;
    };
    
    public func increment_counter():async() {count += 1;};
    public func clear_counter(): async() {count := 0;};

    public func divide(a : Nat, b : Nat) : async Bool {
        return a / b == 0;
    };

    public func is_even(a : Nat) : async Bool {
        return a % 2 == 0;
    };

    public func sum_of_array(a : [Nat]) : async Nat {
        var sum = 0;
        for (i in a.vals()) {sum += i;};
        return sum;
    };

    public func maxium (a: [Nat]) : async Nat {
        var max :Nat = a[0];
        for (i in a.vals()) {
            if (i > max) {max := i;}
        };
        return max;
    };


    public func remove_from_array(a: [Nat], b: Nat) : async [Nat] {
        var ar : [Nat] = [];
        for(i in a.vals()) {
            if (i != b) {ar := Array.append<Nat>(ar, [i]);}
        };
        return ar;
    };

        public func remove_idx_val(a: [Nat], b: Nat) : async [Nat] {
        var ar : [Nat] = [];
        for(i in Iter.range(0, a.size())) {
            if (i != b) {ar := Array.append<Nat>(ar, [i]);}
        };
        return ar;
    };

    public func selection_sort(ar : [Nat]) : async [Nat] {
        return ar;
    };

};