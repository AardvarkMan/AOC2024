codeunit 82029 ARD_AOC202401 implements ARD_AdventOfCodeProcessor
{

    procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        IntegerTable: Record ARD_DoubleIntegerList temporary;
        AOCSupport: Codeunit ARD_AOCSupport;
        Inputs: list of [Text];
        Values: List of [Text];
        IntValuesSorted: List of [Integer];
        TestValue: Text;
        Count: Integer;
        TestInteger1: Integer;
        TestInteger2: Integer;
        Result: Integer;
    begin
        Result := 0;
        if RunExample then
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        Count := 1;
        foreach TestValue in Inputs do begin
            Values := AOCSupport.SplitValues(TestValue);
            System.Evaluate(TestInteger1, Values.Get(1));
            System.Evaluate(TestInteger2, Values.Get(2));

            IntegerTable.Init();
            IntegerTable."ARD_No." := Count;
            IntegerTable.ARD_Value1 := TestInteger1;
            IntegerTable.ARD_Value2 := TestInteger2;
            IntegerTable.Insert();
            Count := Count + 1;
        end;

        IntegerTable.SetCurrentKey(ARD_Value1);
        IntegerTable.Setfilter("ARD_No.", '<>%1', 0);

        if IntegerTable.FindSet() then
            repeat
                IntValuesSorted.Add(IntegerTable.ARD_Value1);
            until IntegerTable.Next() = 0;

        IntegerTable.SetCurrentKey(ARD_Value2);
        IntegerTable.Setfilter("ARD_No.", '<>%1', 0);

        if IntegerTable.FindSet() then begin
            Count := 1;
            repeat
                Result := Result + Abs(IntValuesSorted.Get(Count) - IntegerTable.ARD_Value2);
                Count := Count + 1;
            until IntegerTable.Next() = 0;
        end;

        exit(Result);
    end;

    procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        IntegerTable: Record ARD_DoubleIntegerList temporary;
        AOCSupport: Codeunit ARD_AOCSupport;
        Inputs: list of [Text];
        Values: List of [Text];
        LeftList: List of [Integer];
        TestValue: Text;
        Count: Integer;
        TestInteger1: Integer;
        TestInteger2: Integer;
        Result: Integer;
    begin
        Result := 0;
        if RunExample then
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        Count := 1;
        foreach TestValue in Inputs do begin
            Values := AOCSupport.SplitValues(TestValue);
            System.Evaluate(TestInteger1, Values.Get(1));
            System.Evaluate(TestInteger2, Values.Get(2));
            LeftList.Add(TestInteger1);

            IntegerTable.Init();
            IntegerTable."ARD_No." := Count;
            IntegerTable.ARD_Value1 := TestInteger1;
            IntegerTable.ARD_Value2 := TestInteger2;
            IntegerTable.Insert();
            Count := Count + 1;
        end;

        foreach TestInteger1 in LeftList do begin
            IntegerTable.setfilter(ARD_Value2, '%1', TestInteger1);
            Count := IntegerTable.Count();
            Result := Result + (TestInteger1 * Count);
        end;

        exit(Result);
    end;

}
