codeunit 82030 ARD_AOC202402 implements ARD_AdventOfCodeProcessor
{

    procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Inputs: list of [Text];
        TestValue: Text;
        Values: List of [Text];
        Integers: List of [Integer];
        tmpInteger1: Integer;
        tmpInteger2: Integer;
        Increasing: Boolean;
        Decreasing: Boolean;
        FirstValue: Boolean;
        OverRange: Boolean;
        Result: Integer;
    begin
        Result := 0;
        if RunExample then
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TestValue in Inputs do begin
            Values := AOCSupport.SplitValues(TestValue);
            Increasing := false;
            Decreasing := false;
            FirstValue := true;
            OverRange := false;
            foreach TestValue in Values do begin
                System.Evaluate(tmpInteger1, TestValue);
                if FirstValue = false then begin
                    if tmpInteger1 > tmpInteger2 then Increasing := true;
                    if tmpInteger1 < tmpInteger2 then Decreasing := true;

                    if Abs(tmpInteger1 - tmpInteger2) > 3 then OverRange := true;
                    if (tmpInteger1 - tmpInteger2) = 0 then OverRange := true;
                end;
                FirstValue := false;
                tmpInteger2 := tmpInteger1;
            end;

            if (OverRange = false) AND (Increasing <> Decreasing) then Result := Result + 1;
        end;
        exit(Result);
    end;

    procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Inputs: list of [Text];
        TestValue: Text;
        Values: List of [Text];
        Integers: List of [Integer];
        tmpInteger1: Integer;
        tmpInteger2: Integer;
        Increasing: Boolean;
        Decreasing: Boolean;
        FirstValue: Boolean;
        OverRange: Boolean;
        Processing: Boolean;
        HasFailed: Boolean;
        Result: Integer;
        Fails: Integer;
        Count: Integer;
    begin
        Result := 0;
        Fails := 0;
        if RunExample then
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Inputs := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TestValue in Inputs do begin
            case true of
                EvaluateList(TestValue, 0):
                    Result := Result + 1;
                EvaluateList(TestValue, 1):
                    Result := Result + 1;
                EvaluateList(TestValue, -1):
                    Result := Result + 1;
                EvaluateList(TestValue, -2):
                    Result := Result + 1;
                else
                    Fails := Fails + 1;

            end;

            // if EvaluateList(TestValue, 0) then
            //     Result := Result + 1
            // else if EvaluateList(TestValue, -1) then
            //     Result := Result + 1
            // else if EvaluateList(TestValue, 1) then Result := Result + 1;
        end;

        exit(Result);
    end;

    local procedure EvaluateList(TestValue: Text; Offset: Integer): Boolean
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Values: List of [Text];
        tmpInteger1: Integer;
        tmpInteger2: Integer;
        Increasing: Boolean;
        Decreasing: Boolean;
        FirstValue: Boolean;
        OverRange: Boolean;
        Processing: Boolean;
        HasFailed: Boolean;
        Result: Integer;
        Count: Integer;
    begin
        Values := AOCSupport.SplitValues(TestValue);
        Increasing := false;
        Decreasing := false;
        FirstValue := true;
        OverRange := false;
        Processing := true;
        HasFailed := false;
        Count := 1;
        while Processing do begin
            TestValue := Values.Get(Count);
            System.Evaluate(tmpInteger1, TestValue);
            if FirstValue = false then begin
                if tmpInteger1 > tmpInteger2 then Increasing := true;
                if tmpInteger1 < tmpInteger2 then Decreasing := true;

                if Abs(tmpInteger1 - tmpInteger2) > 3 then OverRange := true;
                if (tmpInteger1 - tmpInteger2) = 0 then OverRange := true;
            end;

            if (HasFailed = false) AND (FirstValue = false) AND ((OverRange = true) OR (Increasing = Decreasing)) then begin
                FirstValue := true;
                HasFailed := true;
                Increasing := false;
                Decreasing := false;
                OverRange := false;
                if ((Count + Offset) > 0) AND ((Count + Offset) <= Values.Count) then Values.RemoveAt(Count + Offset);
                Count := 0;
            end else
                FirstValue := false;

            Count := Count + 1;
            tmpInteger2 := tmpInteger1;
            if Count > Values.Count then Processing := false;
        end;

        if (OverRange = false) AND (Increasing <> Decreasing) then exit(true) else exit(false);
    end;

}
