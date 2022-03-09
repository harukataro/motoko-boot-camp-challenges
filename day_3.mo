import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Array "mo:base/Array";
import Text "mo:base/Text";
import Nat "mo:base/Nat";
import Char "mo:base/Char";
import Option "mo:base/Option";

actor{

    // Challenge 1
    private func swapArrayValue(ar: [var Nat], j:Nat, i:Nat) : [var Nat] {
        let tmp: Nat = ar[j];
        ar[j] := ar[i];
        ar[i] := tmp;
        return ar;
    };

    public func testChap1(ar: [Nat]): async [Nat] {
        var arV = Array.thaw<Nat>(ar);
        var arR = swapArrayValue(arV, 0, 1);
        return Array.freeze<Nat>(arR);
    };


    // Challenge 2
    public func init_count(n: Nat) : async [Nat] {
        var ar : Buffer.Buffer<Nat> = Buffer.Buffer(n);
        for( i in Iter.range(0, n-1)) {
            ar.add(i);
        };
        return ar.toArray();
    };

    //Challenge 3
    public func seven(n: Nat): async Bool{
        let t = Nat.toText(n);
        for(c in t.chars()) {
            if(Char.equal(c, '7')){
                return true;
            };
        };
        return false;
    };

    //Challenge 4
    public func nat_opt_to_nat(n: ?Nat, m: Nat): async Nat {
        let ans = Option.get(n,m);
        return ans;
    };

    //Challenge 5
    public func day_of_the_week(n: Nat): async ?Text {
        switch n {
            case 1
                return Option.make<Text>("Monday");
            case(2){
                return Option.make<Text>("Tuseday");
            };
            case(3){
                return Option.make<Text>("Wednesday");
            };
            case(4){
                return Option.make<Text>("Thursday");
            };
            case(5){
                return Option.make<Text>("Friday");
            };
            case(6){
                return Option.make<Text>("Saturday");
            };
            case(7){
                return Option.make<Text>("Sunday");
            };
            case _
                return null;
        };
    };

    //Challenge 6
    let no_null = func (n: ?Nat): ?Nat {
        switch(n){
            case(null){
                return ?0;
            };
            case(?Nat){
                return n;
            };
        };
    };

    public func populate_array(a: [?Nat]): async [Nat]{
        let ans = Array.mapFilter(a, no_null);
        return ans;
    };

    //Challenge 7
    let add_f = func (n: Nat, m: Nat): Nat {
        return n + m;
    };

    public func sum_of_array(a: [Nat]): async Nat{
        let ans = Array.foldLeft(a, 0, add_f);
        return ans;
    };

    //Challenge 8
    let sq = func (n: Nat): Nat {
        return n * n;
    };
    public func squared_array(a: [Nat]): async [Nat]{
        let ans = Array.map(a, sq);
        return ans;
    };

    //Challenge 9
    let add_idx = func (n: Nat, m: Nat): Nat {
        return n + m;
    };
    public func increase_by_index(a: [Nat]): async [Nat]{
        let ans = Array.mapEntries(a, add_idx);
        return ans;
    };

    //Challenge 10
    private func contains<A>(a: [A], x: A, f: ((A, A))-> Bool ): Bool {
        for(i in Iter.range(0, a.size()-1)) {
            if(f(a[i], x)) {
                return true;
            };
        };
        return false;
    };

    let eq = func(a:(Nat,Nat)): Bool {
        return a.0 == a.1;
    };
    public func testChap10(a: [Nat], x:Nat): async Bool {
        let ans = contains<Nat>(a, x, eq);
        return ans;
    };
}
