
import Option "mo:base/Option";

module{
    public type List<T> = ?(T, List<T>);

    public func is_null<T>(l: List<T>) : async Bool{
        switch(l){
            case (null){ 
                return true;
            };
            case (_){
                return false;
            };
        };
    };

    func last<T>(l: List<T>) : ?T{
        switch(l){
            case (null){ 
                return null;
            };
            case (?(_, t)){
                return last<T>(t);
            };
        };
    };

    public func size<T>(l : List<T>) : Nat {
        func rec(l : List<T>, n : Nat) : Nat {
            switch l {
                case null { n };
                case (?(_, t)) { rec(t, n + 1) };
            }
        };
        rec(l,0)
    };

    func get<T>(l: List<T>, n: Nat) : ?T{
        switch(l){
            case (null){ null};
            case (?(_, t)){get<T>(t, n - 1)};
        }
    };
}