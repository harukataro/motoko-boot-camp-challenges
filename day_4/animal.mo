
module{
    public type Animal = {
        name: Text;
        energy: Nat;
    };

    public func animal_sleep(animal: Animal) : async Animal{
        var  ans: Animal = {
            name = animal.name;
            energy = animal.energy + 10;
        };
        return ans;
    };
};