codeunit 82032 ARD_AOC202405 implements ARD_AdventOfCodeProcessor
{

    procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        TempRules: Record ARD_DoubleIntegerList temporary;
        AOCSupport: Codeunit ARD_AOCSupport;
        Lines: List of [Text];
        TestValue: Text;
        tmpList: List of [Text];
        Changes: List of [Text];
        TempInt1: Integer;
        TempInt2: Integer;
        Result: Integer;
        Count: Integer;
    begin
        Count := 0;
        Result := 0;
        if RunExample then
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TestValue in Lines do
            if TestValue.Contains('|') then begin
                tmpList := TestValue.Split('|');
                System.Evaluate(TempInt1, tmpList.Get(1));
                System.Evaluate(TempInt2, tmpList.Get(2));
                Count += 1;
                TempRules.Init();
                TempRules."ARD_No." := Count;
                TempRules.ARD_Value1 := TempInt1;
                TempRules.ARD_Value2 := TempInt2;
                TempRules.Insert();
            end
            else
                if TestValue <> '' then
                    Changes.Add(TestValue);

        foreach TestValue in Changes do
            Result := Result + ValidateChange(TempRules, TestValue);

        exit(Result);
    end;

    local procedure ValidateChange(var TempRules: Record ARD_DoubleIntegerList; RecordChange: Text): Integer
    var
        TextChanges: List of [Text];
        IntChanges: List of [Integer];
        Change: Text;
        TempInt: Integer;
    begin
        TextChanges := RecordChange.split(',');
        foreach Change in TextChanges do begin
            System.Evaluate(TempInt, Change);
            IntChanges.Add(TempInt);
        end;

        TempRules.Setfilter("ARD_No.", '<>%1', 0);
        if TempRules.FindSet() then
            repeat
                if (IntChanges.Contains(TempRules.ARD_Value1)) AND (IntChanges.Contains(TempRules.ARD_Value2)) then
                    if IntChanges.indexof(TempRules.ARD_Value1) > IntChanges.indexof(TempRules.ARD_Value2) then
                        exit(0);
            until TempRules.Next() = 0;

        TempInt := System.Round(IntChanges.Count() / 2, 1, '>');
        TempInt := IntChanges.Get(TempInt);
        exit(TempInt);
    end;

    procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        TempRules: Record ARD_DoubleIntegerList temporary;
        AOCSupport: Codeunit ARD_AOCSupport;
        Lines: List of [Text];
        TestValue: Text;
        tmpList: List of [Text];
        Changes: List of [Text];
        TempInt1: Integer;
        TempInt2: Integer;
        Result: Integer;
        Count: Integer;
    begin
        Count := 0;
        Result := 0;
        if RunExample then
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TestValue in Lines do
            if TestValue.Contains('|') then begin
                tmpList := TestValue.Split('|');
                System.Evaluate(TempInt1, tmpList.Get(1));
                System.Evaluate(TempInt2, tmpList.Get(2));
                Count += 1;
                TempRules.Init();
                TempRules."ARD_No." := Count;
                TempRules.ARD_Value1 := TempInt1;
                TempRules.ARD_Value2 := TempInt2;
                TempRules.Insert();
            end
            else
                if TestValue <> '' then
                    Changes.Add(TestValue);

        foreach TestValue in Changes do
            Result := Result + FixAlignmentChange(TempRules, TestValue);

        exit(Result);
    end;

    local procedure FixAlignmentChange(var TempRules: Record ARD_DoubleIntegerList; RecordChange: Text): Integer
    var
        TextChanges: List of [Text];
        IntChanges: List of [Integer];
        Change: Text;
        TempInt: Integer;
        Processing: Boolean;
        DataFixed: Boolean;
        PerfectRun: Boolean;
        Index1: Integer;
        Index2: Integer;
    begin
        DataFixed := false;
        TextChanges := RecordChange.split(',');
        foreach Change in TextChanges do begin
            System.Evaluate(TempInt, Change);
            IntChanges.Add(TempInt);
        end;

        Processing := true;
        while Processing do begin
            PerfectRun := true;
            TempRules.Setfilter("ARD_No.", '<>%1', 0);
            if TempRules.FindSet() then
                repeat
                    if (IntChanges.Contains(TempRules.ARD_Value1)) AND (IntChanges.Contains(TempRules.ARD_Value2)) then
                        if IntChanges.indexof(TempRules.ARD_Value1) > IntChanges.indexof(TempRules.ARD_Value2) then begin
                            DataFixed := true;
                            PerfectRun := false;
                            Index1 := IntChanges.indexof(TempRules.ARD_Value1);
                            Index2 := IntChanges.indexof(TempRules.ARD_Value2);

                            TempInt := IntChanges.Get(Index1);
                            IntChanges.Set(Index1, IntChanges.Get(IntChanges.indexof(TempRules.ARD_Value2)));
                            IntChanges.Set(Index2, TempInt);
                        end;
                until TempRules.Next() = 0;

                if PerfectRun then
                    Processing := false;
        end;

        if DataFixed then begin
            TempInt := System.Round(IntChanges.Count() / 2, 1, '>');
            TempInt := IntChanges.Get(TempInt);
            exit(TempInt);
        end;

        exit(0);
    end;

}
