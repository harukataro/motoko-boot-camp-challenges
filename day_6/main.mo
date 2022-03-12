import HashMap "mo:base/HashMap";
import Principal "mo:base/Principal";
import Result "mo:base/Result";
import Array "mo:base/Array";
import HTTP "http";
import Hash "mo:base/Hash";
import Prim "mo:prim";
import Text "mo:base/Text";
import Buffer "mo:base/Buffer";
import Iter "mo:base/Iter";
import Nat "mo:base/Nat";
import Option "mo:base/Option";

actor {
    public type Result<T,E> = Result.Result<T,E>;
    type TokenIndex = Nat;
    let anonymous_principal : Principal.Principal = Principal.fromText("2vxsx-fae");

    type Error = {
        #Bad;
        #SuperBad;
        #UltraBad;
    };
    let eq: (Nat,Nat) ->Bool = func(x, y) { x == y };
    let keyHash: (Nat) -> Hash.Hash = func(x) { Prim.natToNat32 x };
    var registry = HashMap.HashMap<TokenIndex, Principal.Principal>(0, eq, keyHash);
    
    var nextTokenIndex: TokenIndex = 0;
    

    public shared(msg) func mint(): async Result<(), Text>{
        let principal_caller = msg.caller;
        if(Principal.equal(principal_caller, anonymous_principal)) {
            return #err("anonymous principal");
        }else{
            registry.put(nextTokenIndex, principal_caller);
            #ok;
        }
    };

    public  shared(msg) func transfer(to: Principal, tokenIdx: Nat): async Result<(), Text> {
        let p = registry.get(tokenIdx);
        let principal_caller = msg.caller;
        switch(p){
            case(null){
                return #err("token not found");
            };
            case(_){
                let p_unwrap = Option.get(p, anonymous_principal);
                if(Principal.equal(principal_caller, p_unwrap)){
                    let sta = registry.replace(tokenIdx, to);
                    switch(sta){
                        case(null){return #err("token not found");};
                        case(_){return #ok;};
                    };
                }else{
                    return #err("not owner");
                };
            };
        };
    };

    public shared(msg) func balance():async [Nat] {
        var list = Buffer.Buffer<Nat>(0);
        let principal_caller = msg.caller;
        for(i in Iter.range(0, nextTokenIndex -2)) {
            let v = registry.get(i);
            switch(v){
                case (null) {};
                case (_){
                    let p = Option.get(v, anonymous_principal);
                    if(Principal.equal(p,principal_caller)) {
                        list.add(i);
                    };
                };
            };
        };
        return list.toArray();
    };

    public query func http_request(request : HTTP.Request) : async HTTP.Response {
        let response = {
            body = Text.encodeUtf8("Latest Mint Num" # Nat.toText(nextTokenIndex -1));
            headers = [("Content-Type", "text/html; charset=UTF-8")];
            status_code = 200 : Nat16;
            streaming_strategy = null
        };
        return(response)
    };

    //Challenge9
    public func default_account() : async Text {
        ""
    };

    //Challenge10
    public shared(caller) func balance2(): async Nat {
        0
    };

}