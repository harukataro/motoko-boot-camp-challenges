import Array "mo:base/Array";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Buffer "mo:base/Buffer";

actor {

    stable var count = 0 :Nat;

    // Challenge 1
    public func add(a : Nat, b : Nat) : async Nat {
        return a + b;
    };

    // Challenge 2
    public func square(a : Nat) : async Nat {
        return a * a;
    };

    // Challenge 3
    public func days_to_second(days : Nat) : async Nat {
        return days * 24 * 60 * 60;
    };
    
    // Challenge 4
    public func increment_counter(): async Nat {
        count += 1;
        return count;
        };
    
    public func clear_counter(): async() {count := 0;};

    // Challenge 5
    public func divide(a : Nat, b : Nat) : async Bool {
        return a / b == 0;
    };

    // Challenge 6
    public func is_even(a : Nat) : async Bool {
        return a % 2 == 0;
    };

    // Challenge 7
    public func sum_of_array(a : [Nat]) : async Nat {
        var sum = 0;
        for (i in a.vals()) {sum += i;};
        return sum;
    };

    // Challenge 8
    public func maxium (a: [Nat]) : async Nat {
        var max :Nat = a[0];
        for (i in a.vals()) {
            if (i > max) {max := i;}
        };
        return max;
    };

        // Challenge 9
    public func remove_from_array(a: [Nat], b: Nat) : async [Nat] {
        var ar : Buffer.Buffer<Nat> = Buffer.Buffer(0);
        for(i in a.vals()) {
            if (i != b) {ar.add(i);}
        };
        return ar.toArray();
    };


    // Challenge 10
    public func selection_sort(ar : [Nat]) : async [Nat] {
        let a: [var Nat] = Array.thaw<Nat>(ar);
        let a_idx_max = a.size() - 1;
        for (i in Iter.range(0, a_idx_max -1)) {
            var min = i;
            for (j in Iter.range(i + 1, a_idx_max)) {
                if (a[j] < a[min]) {min := j;}
            };
            if(min != i){
                let tmp = a[i];
                a[i] := a[min];
                a[min] := tmp;
            }
        }; 
        return Array.freeze<Nat>(a);
    };
};