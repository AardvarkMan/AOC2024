codeunit 82028 ARD_AOC202404 implements ARD_AdventOfCodeProcessor
{

    // This procedure calculates the result based on the given record and example flag.
    // It processes the challenge data or example, splits it into lines, and converts each line into a matrix of characters.
    // It then searches for occurrences of a specific sequence of characters in the matrix in various directions.
    // Parameters:
    //   Rec: Record of type ARD_AOCChallenge containing the challenge data.
    //   RunExample: Boolean flag indicating whether to run the example data or the actual challenge data.
    // Returns:
    //   Integer: The count of occurrences of the specified character sequence in the matrix.
    procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Matrix: list of [list of [Char]];
        CharArray: list of [Char];
        SearchArray: list of [Char];
        Lines: List of [Text];
        TextValue: Text;
        testChar: Char;
        MatrixRow: Integer;
        MatrixColumn: Integer;
        Result: Integer;
    begin
        Result := 0;
        SearchArray.Add('x');
        SearchArray.Add('m');
        SearchArray.Add('a');
        SearchArray.Add('s');

        if RunExample then
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TextValue in lines do begin
            clear(CharArray);
            foreach testChar in TextValue.ToLower() do
                CharArray.Add(testChar);

            Matrix.add(CharArray);
        end;

        MatrixRow := 0;
        MatrixColumn := 0;

        foreach CharArray in Matrix do begin
            MatrixRow += 1;
            MatrixColumn := 0;
            foreach testChar in CharArray do begin
                MatrixColumn += 1;
                if testChar = SearchArray.Get(1) then begin
                    if SearchMatrix(Matrix, SearchArray, MatrixRow, MatrixColumn, 0, 1) then Result := Result + 1;
                    if SearchMatrix(Matrix, SearchArray, MatrixRow, MatrixColumn, 1, 0) then Result := Result + 1;
                    if SearchMatrix(Matrix, SearchArray, MatrixRow, MatrixColumn, 0, -1) then Result := Result + 1;
                    if SearchMatrix(Matrix, SearchArray, MatrixRow, MatrixColumn, -1, 0) then Result := Result + 1;
                    if SearchMatrix(Matrix, SearchArray, MatrixRow, MatrixColumn, 1, 1) then Result := Result + 1;
                    if SearchMatrix(Matrix, SearchArray, MatrixRow, MatrixColumn, 1, -1) then Result := Result + 1;
                    if SearchMatrix(Matrix, SearchArray, MatrixRow, MatrixColumn, -1, 1) then Result := Result + 1;
                    if SearchMatrix(Matrix, SearchArray, MatrixRow, MatrixColumn, -1, -1) then Result := Result + 1;
                end;
            end;

        end;

        exit(Result);
    end;

    // This procedure searches for a sequence of characters (SearchArray) in a 2D matrix (Matrix) starting from a specified position (Row, Column).
    // It checks if the sequence can be found in the matrix by moving in the direction specified by RowCount and ColumnCount.
    // 
    // Parameters:
    //   - Matrix: list of list of Char - The 2D matrix to search within.
    //   - SearchArray: list of Char - The sequence of characters to search for.
    //   - Row: Integer - The starting row position in the matrix.
    //   - Column: Integer - The starting column position in the matrix.
    //   - RowCount: Integer - The row increment to move in the matrix for each character in the SearchArray.
    //   - ColumnCount: Integer - The column increment to move in the matrix for each character in the SearchArray.
    // 
    // Returns:
    //   - Boolean - True if the sequence is found in the matrix, otherwise false.
    local procedure SearchMatrix(Matrix: list of [list of [Char]]; SearchArray: list of [Char]; Row: Integer; Column: Integer; RowCount: Integer; ColumnCount: Integer): Boolean
    var
        Found: Boolean;
        SearchChar: Char;
    begin
        Found := true;

        foreach SearchChar in SearchArray do begin
            if (Row > matrix.Count) OR (Row < 1) then begin
                Found := false;
                break;
            end;

            if (Column > matrix.get(Row).Count) OR (Column < 1) then begin
                Found := false;
                break;
            end;

            if matrix.get(Row).get(Column) <> SearchChar then begin
                Found := false;
                break;
            end;

            Column += ColumnCount;
            Row += RowCount;
        end;

        exit(Found);
    end;



    /// <summary>
    /// Calculates the result based on the given record and whether to run the example or not.
    /// </summary>
    /// <param name="Rec">The record containing the challenge data.</param>
    /// <param name="RunExample">Boolean flag indicating whether to run the example or the actual challenge data.</param>
    /// <returns>The calculated result as an integer.</returns>
    /// <remarks>
    /// This procedure processes the challenge data by splitting it into lines, converting each line to a list of characters,
    /// and then storing these lists in a matrix. It then iterates through the matrix to count occurrences of the character 'a'
    /// that meet a specific condition defined by the XTest function.
    /// </remarks>
    procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Integer
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Matrix: list of [list of [Char]];
        CharArray: list of [Char];
        SearchArray: list of [Char];
        Lines: List of [Text];
        TextValue: Text;
        testChar: Char;
        MatrixRow: Integer;
        MatrixColumn: Integer;
        Result: Integer;
    begin
        Result := 0;
        SearchArray.Add('x');
        SearchArray.Add('m');
        SearchArray.Add('a');
        SearchArray.Add('s');

        if RunExample then
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeExample())
        else
            Lines := AOCSupport.SplitLines(Rec.RetrieveChallengeData());

        foreach TextValue in lines do begin
            clear(CharArray);
            foreach testChar in TextValue.ToLower() do
                CharArray.Add(testChar);

            Matrix.add(CharArray);
        end;

        MatrixRow := 0;
        MatrixColumn := 0;

        foreach CharArray in Matrix do begin
            MatrixRow += 1;
            MatrixColumn := 0;
            foreach testChar in CharArray do begin
                MatrixColumn += 1;
                if testChar = 'a' then
                    if XTest(Matrix, MatrixRow, MatrixColumn) then Result := Result + 1;
            end;
        end;

        exit(Result);
    end;

    // This procedure checks if a given position in a matrix forms an 'X' pattern with specific conditions.
    // The 'X' pattern is formed by checking the characters at the upper-left, upper-right, lower-left, and lower-right
    // positions relative to the given row and column.
    // The conditions for forming an 'X' are:
    // - The position should not be too close to the edges of the matrix.
    // - The characters at the four positions should include exactly two 'm' characters and two 's' characters.
    // - The upper-left and lower-right characters should not be the same.
    //
    // Parameters:
    //   - Matrix: A list of lists of characters representing the matrix.
    //   - Row: The row index of the position to check.
    //   - Column: The column index of the position to check.
    //
    // Returns:
    //   - Boolean: True if the position forms an 'X' pattern with the specified conditions, otherwise false.
    local procedure XTest(Matrix: list of [list of [Char]]; Row: Integer; Column: Integer): Boolean
    var
        charUL: Char;
        charUR: Char;
        charLL: Char;
        charLR: Char;
        MCount: Integer;
        SCount: Integer;
    begin
        MCount := 0;
        SCount := 0;

        //Too close to the top or bottom edge to form an X
        if (Row > matrix.Count - 1) OR (Row < 2) then
            exit(false);
        
        //Too close to the left or right edge to form an X
        if(Column > matrix.get(Row).Count - 1) OR (Column < 2) then
            exit(false);

        charUL := matrix.get(Row - 1).get(Column - 1);
        charUR := matrix.get(Row - 1).get(Column + 1);
        charLL := matrix.get(Row + 1).get(Column - 1);
        charLR := matrix.get(Row + 1).get(Column + 1);

        if charUL = 'm' then MCount += 1;
        if charUR = 'm' then MCount += 1;
        if charLL = 'm' then MCount += 1;
        if charLR = 'm' then MCount += 1;

        if charUL = 's' then SCount += 1;
        if charUR = 's' then SCount += 1;
        if charLL = 's' then SCount += 1;
        if charLR = 's' then SCount += 1;

        if (Mcount = 2) and (SCount = 2) and (charUL <> charLR) then
            exit(true)
        else
            exit(false);
    end; 



}
