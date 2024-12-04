codeunit 82029 ARD_AOC202401 implements ARD_AdventOfCodeProcessor
{
    // This procedure calculates a result based on the provided ARD_AOCChallenge record.
    // It processes either example data or actual challenge data depending on the RunExample flag.
    // The procedure performs the following steps:
    // 1. Retrieves and splits the input data into lines.
    // 2. Iterates through each line, splits the values, evaluates them as integers, and stores them in a temporary table.
    // 3. Adds the first integer of each line to a list.
    // 4. Iterates through the list of integers, filters the temporary table based on the second integer value, counts the matches, and calculates the result.
    // 
    // Parameters:
    //   Rec: Record ARD_AOCChallenge - The challenge record containing the data to be processed.
    //   RunExample: Boolean - Flag indicating whether to run the example data or the actual challenge data.
    // 
    // Returns:
    //   Integer - The calculated result based on the processed data.
    procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        TempIntegerTable: Record ARD_DoubleIntegerList temporary;
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

            TempIntegerTable.Init();
            TempIntegerTable."ARD_No." := Count;
            TempIntegerTable.ARD_Value1 := TestInteger1;
            TempIntegerTable.ARD_Value2 := TestInteger2;
            TempIntegerTable.Insert();
            Count := Count + 1;
        end;

        TempIntegerTable.SetCurrentKey(ARD_Value1);
        TempIntegerTable.Setfilter("ARD_No.", '<>%1', 0);

        if TempIntegerTable.FindSet() then
            repeat
                IntValuesSorted.Add(TempIntegerTable.ARD_Value1);
            until TempIntegerTable.Next() = 0;

        TempIntegerTable.SetCurrentKey(ARD_Value2);
        TempIntegerTable.Setfilter("ARD_No.", '<>%1', 0);

        if TempIntegerTable.FindSet() then begin
            Count := 1;
            repeat
                Result := Result + Abs(IntValuesSorted.Get(Count) - TempIntegerTable.ARD_Value2);
                Count := Count + 1;
            until TempIntegerTable.Next() = 0;
        end;

        exit(Result);
    end;

    // This procedure calculates a result based on the provided ARD_AOCChallenge record.
    // It processes either example data or actual challenge data depending on the RunExample flag.
    // The procedure performs the following steps:
    // 1. Retrieves and splits the input data into lines.
    // 2. Iterates through each line, splits the values, evaluates them as integers, and stores them in a temporary table.
    // 3. Adds the first integer of each line to a list.
    // 4. Iterates through the list of integers, filters the temporary table based on the second integer value, counts the matches, and calculates the result.
    // 
    // Parameters:
    //   Rec: Record ARD_AOCChallenge - The challenge record containing the data to be processed.
    //   RunExample: Boolean - Flag indicating whether to run the example data or the actual challenge data.
    // 
    // Returns:
    //   Integer - The calculated result based on the processed data.
    procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        TempIntegerTable: Record ARD_DoubleIntegerList temporary;
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

            TempIntegerTable.Init();
            TempIntegerTable."ARD_No." := Count;
            TempIntegerTable.ARD_Value1 := TestInteger1;
            TempIntegerTable.ARD_Value2 := TestInteger2;
            TempIntegerTable.Insert();
            Count := Count + 1;
        end;

        foreach TestInteger1 in LeftList do begin
            TempIntegerTable.setfilter(ARD_Value2, '%1', TestInteger1);
            Count := TempIntegerTable.Count();
            Result := Result + (TestInteger1 * Count);
        end;

        exit(Result);
    end;

}
