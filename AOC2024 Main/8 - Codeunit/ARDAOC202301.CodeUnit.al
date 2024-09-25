codeunit 82024 ARD_AOC202301 implements ARD_AdventOfCodeProcessor
{
    Procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        Results: Integer;
    begin
        if RunExample then
            Results := Calc2023011(Rec.RetrieveChallengeExample())
        else
            Results := Calc2023011(Rec.RetrieveChallengeData());

        exit(Results);
    end;

    Procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    begin
        exit(0);
    end;

    //AOC 2023 Day 1
    local Procedure Calc2023011(Input: Text): Integer
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Inputs: list of [Text];
        TestValue: Text;
        Testcharacter: integer;
        Result: Integer;
        FirstNumber: Integer;
        LastNumber: Integer;
        LineValue: Integer;
    begin
        Result := 0;
        Inputs := AOCSupport.SplitLines(Input);

        foreach TestValue in Inputs do begin
            FirstNumber := -1;
            LastNumber := -1;
            LineValue := 0;
            foreach Testcharacter in TestValue do
                if (TestCharacter > 47) AND (Testcharacter < 58) then begin
                    if FirstNumber < 0 then
                        FirstNumber := TestCharacter - 48;

                    LastNumber := Testcharacter - 48;
                end;

            LineValue := (FirstNumber * 10) + LastNumber;
            Result := Result + LineValue;
        end;

        exit(Result);
    end;
}
