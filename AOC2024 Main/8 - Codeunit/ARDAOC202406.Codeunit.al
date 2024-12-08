codeunit 82033 ARD_AOC202406 implements ARD_AdventOfCodeProcessor
{

    procedure CalculateResult1(Rec: record ARD_AOCChallenge; RunExample: Boolean): Decimal
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Matrix: list of [list of [text]];
        Lines: List of [Text];
        TextValue: Text;
        CharArray: list of [text];
        testChar: Char;

        positionX: Integer;
        positionY: Integer;
        steps: Integer;
        directionX: Integer;
        directionY: Integer;
    begin
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

        directionX := 0;
        directionY := -1;
        steps := 1;
        FindStart(Matrix, positionX, positionY);
        navigatemapNR(Matrix, positionX, positionY, directionX, directionY, steps);

        exit(steps);
    end;

    local procedure FindStart(MAP: list of [list of [text]]; var positionX: Integer; var positionY: integer)
    var
        CharArray: list of [text];
        currChar: text;
    begin
        foreach CharArray in MAP do begin
            positionY += 1;
            positionX := 0;
            foreach currChar in CharArray do begin
                positionX += 1;
                if currChar = '^' then
                    exit;
            end;
        end;
    end;

    /// <summary>
    /// Navigates through a map represented as a list of lists of text, updating the position and direction based on the encountered blocks.
    /// </summary>
    /// <param name="MAP">The map to navigate, represented as a list of lists of text.</param>
    /// <param name="positionX">The current X position on the map, passed by reference.</param>
    /// <param name="positionY">The current Y position on the map, passed by reference.</param>
    /// <param name="directionX">The current X direction of movement, passed by reference.</param>
    /// <param name="directionY">The current Y direction of movement, passed by reference.</param>
    /// <param name="steps">The number of steps taken, passed by reference.</param>
    /// <returns>Returns true if the navigation goes out of bounds, otherwise continues navigating.</returns>
    /// <remarks>
    /// The procedure marks the current position with 'X' and updates the position based on the direction.
    /// If the position goes out of bounds, it exits with true.
    /// If a wall ('#') is encountered, it changes the direction in a specific order.
    /// If an empty space ('.') is encountered, it increments the steps counter.
    /// </remarks>
    local procedure navigatemapNR(MAP: list of [list of [text]]; var positionX: Integer; var positionY: integer; var directionX: Integer; var directionY: Integer; var steps: Integer): Boolean
    var
        NextBlock: text;
        DirectionSet: Boolean;
        Searching: Boolean;
    begin
        Searching := true;

        while Searching do begin

            MAP.Get(positionY).Set(positionX, 'X');

            positionX += directionX;
            positionY += directionY;

            //out of bounds
            if (positionX < 1) or (positionX > MAP.Get(1).Count) then
                exit(true);
            if (positionY < 1) or (positionY > map.Count) then
                exit(true);

            NextBlock := MAP.Get(positionY).Get(positionX);
            if NextBlock = '#' then begin
                //hit a wall
                DirectionSet := false;
                positionX -= directionX;
                positionY -= directionY;

                if (DirectionSet = false) AND (directionX = -1) then begin
                    directionX := 0;
                    directionY := -1;
                    DirectionSet := true;
                end;

                if (DirectionSet = false) AND (directionX = 1) then begin
                    directionX := 0;
                    directionY := 1;
                    DirectionSet := true;
                end;

                if (DirectionSet = false) AND (directionY = 1) then begin
                    directionX := -1;
                    directionY := 0;
                    DirectionSet := true;
                end;

                if (DirectionSet = false) AND (directionY = -1) then begin
                    directionX := 1;
                    directionY := 0;
                    DirectionSet := true;
                end;
            end else
                if NextBlock = '.' then steps += 1;
        end;
    end;

        /// <summary>
    /// Navigates through a map represented as a list of lists of text, updating the position and direction based on the encountered blocks.
    /// </summary>
    /// <param name="MAP">The map to navigate, represented as a list of lists of text.</param>
    /// <param name="positionX">The current X position on the map, passed by reference.</param>
    /// <param name="positionY">The current Y position on the map, passed by reference.</param>
    /// <param name="directionX">The current X direction of movement, passed by reference.</param>
    /// <param name="directionY">The current Y direction of movement, passed by reference.</param>
    /// <param name="steps">The number of steps taken, passed by reference.</param>
    /// <returns>Returns true if the navigation goes out of bounds, otherwise continues navigating.</returns>
    /// <remarks>
    /// The procedure marks the current position with 'X' and updates the position based on the direction.
    /// If the position goes out of bounds, it exits with true.
    /// If a wall ('#') is encountered, it changes the direction in a specific order.
    /// If an empty space ('.') is encountered, it increments the steps counter.
    /// This procedure runs recursively. It works fine for the example data, but it will not work for the challenge data due to the large number of recursive calls.
    /// </remarks>
    local procedure navigatemap(MAP: list of [list of [text]]; var positionX: Integer; var positionY: integer; var directionX: Integer; var directionY: Integer; var steps: Integer): Boolean
    var
        NextBlock: text;
        DirectionSet: Boolean;
    begin
        MAP.Get(positionY).Set(positionX, 'X');

        positionX += directionX;
        positionY += directionY;

        //out of bounds
        if (positionX < 1) or (positionX > MAP.Get(1).Count) then
            exit(true);
        if (positionY < 1) or (positionY > map.Count) then
            exit(true);

        NextBlock := MAP.Get(positionY).Get(positionX);
        if NextBlock = '#' then begin
            //hit a wall
            DirectionSet := false;
            positionX -= directionX;
            positionY -= directionY;

            if (DirectionSet = false) AND (directionX = -1) then begin
                directionX := 0;
                directionY := -1;
                DirectionSet := true;
            end;

            if (DirectionSet = false) AND (directionX = 1) then begin
                directionX := 0;
                directionY := 1;
                DirectionSet := true;
            end;

            if (DirectionSet = false) AND (directionY = 1) then begin
                directionX := -1;
                directionY := 0;
                DirectionSet := true;
            end;

            if (DirectionSet = false) AND (directionY = -1) then begin
                directionX := 1;
                directionY := 0;
                DirectionSet := true;
            end
        end else
            if NextBlock = '.' then steps += 1;

        exit(navigatemap(MAP, positionX, positionY, directionX, directionY, steps));
    end;

    procedure CalculateResult2(Rec: record ARD_AOCChallenge; RunExample: Boolean): Decimal
    var
        AOCSupport: Codeunit ARD_AOCSupport;
        Matrix: list of [list of [text]];
        Lines: List of [text];
        TextValue: Text;
        CharArray: list of [text];
        testChar: Char;

        positionX: Integer;
        positionY: Integer;
        steps: Integer;
        directionX: Integer;
        directionY: Integer;
    begin
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

        directionX := 0;
        directionY := -1;
        steps := 0;
        FindStart(Matrix, positionX, positionY);
        navigatemapNRWithBlocks(Matrix, positionX, positionY, directionX, directionY, steps);

        exit(steps);
    end;

    /// <summary>
    /// Navigates through a map represented as a list of lists of text, updating the position and direction based on the encountered blocks.
    /// </summary>
    /// <param name="MAP">The map to navigate, represented as a list of lists of text.</param>
    /// <param name="positionX">The current X position on the map, passed by reference.</param>
    /// <param name="positionY">The current Y position on the map, passed by reference.</param>
    /// <param name="directionX">The current X direction of movement, passed by reference.</param>
    /// <param name="directionY">The current Y direction of movement, passed by reference.</param>
    /// <param name="steps">The number of steps taken, passed by reference.</param>
    /// <returns>Returns true if the navigation goes out of bounds, otherwise continues navigating.</returns>
    /// <remarks>
    /// The procedure marks the current position with 'X' and updates the position based on the direction.
    /// If the position goes out of bounds, it exits with true.
    /// If a wall ('#') is encountered, it changes the direction in a specific order.
    /// If an empty space ('.') is encountered, it increments the steps counter.
    /// This procedure attempts to find a means to cause a loop, but it is not working as intended.
    /// Without recursion I'm not able to sort out a way to validate the process and may have to revisit it later.
    /// </remarks>
    local procedure navigatemapNRWithBlocks(MAP: list of [list of [text]]; var positionX: Integer; var positionY: integer; var directionX: Integer; var directionY: Integer; var steps: Integer): Boolean
    var
        NextBlock: text;
        DirectionSet: Boolean;
        Searching: Boolean;
        PositionIndicatorChar: text;
    begin
        Searching := true;
        PositionIndicatorChar := '^';

        while Searching do begin
            PositionIndicatorChar := MAP.Get(positionY).Get(positionX);

            if directionX = -1 then PositionIndicatorChar := PositionIndicatorChar + '<';
            if directionX = 1 then PositionIndicatorChar := PositionIndicatorChar + '>';
            if directionY = 1 then PositionIndicatorChar := PositionIndicatorChar + 'v';
            if directionY = -1 then PositionIndicatorChar := PositionIndicatorChar + '^';

            MAP.Get(positionY).Set(positionX, PositionIndicatorChar);

            positionX += directionX;
            positionY += directionY;

            //out of bounds
            if (positionX < 1) or (positionX > MAP.Get(1).Count) then
                exit(true);
            if (positionY < 1) or (positionY > map.Count) then
                exit(true);

            NextBlock := MAP.Get(positionY).Get(positionX);
            if NextBlock = '#' then begin
                //hit a wall
                DirectionSet := false;
                positionX -= directionX;
                positionY -= directionY;

                if (DirectionSet = false) AND (directionX = -1) then begin
                    directionX := 0;
                    directionY := -1;
                    DirectionSet := true;
                end;

                if (DirectionSet = false) AND (directionX = 1) then begin
                    directionX := 0;
                    directionY := 1;
                    DirectionSet := true;
                end;

                if (DirectionSet = false) AND (directionY = 1) then begin
                    directionX := -1;
                    directionY := 0;
                    DirectionSet := true;
                end;

                if (DirectionSet = false) AND (directionY = -1) then begin
                    directionX := 1;
                    directionY := 0;
                    DirectionSet := true;
                end;
            end else
                if checkForBlock(Map, positionX, positionY, directionX, directionY) then
                    Steps := Steps + 1;
        end;
    end;

    local procedure checkForBlock(var MAP: list of [list of [text]]; positionX: Integer; positionY: integer; directionX: Integer; directionY: Integer): Boolean
    var
        searchindDirection: Integer;
    begin

        if directionX = -1 then begin
            if positionY - 1 < 1 then exit(false);
            if positionX + 1 > MAP.Get(1).Count then exit(false);

            searchindDirection := positionY - 1;
            while searchindDirection > 0 do begin
                if (MAP.Get(searchindDirection).Get(positionX + 1).Contains('^')) or (MAP.Get(searchindDirection).Get(positionX + 1).Contains('#')) then
                    exit(true);
                searchindDirection -= 1;
            end;
        end;

        if directionX = 1 then begin
            if positionY + 1 > MAP.Count() then exit(false);
            if positionX - 1 < 1 then exit(false);

            searchindDirection := positionY + 1;
            while searchindDirection < MAP.Count() do begin
                if (MAP.Get(searchindDirection).Get(positionX - 1).Contains('v')) or (MAP.Get(searchindDirection).Get(positionX + 1).Contains('#')) then
                    exit(true);
                searchindDirection += 1;
            end;
        end;

        if directionY = -1 then begin
            if positionY + 1 > MAP.Count() then exit(false);
            if positionX + 1 > MAP.Get(1).Count then exit(false);

            searchindDirection := positionX + 1;
            while searchindDirection < MAP.Get(1).Count do begin
                if (MAP.Get(positionY + 1).Get(searchindDirection).Contains('>')) or (MAP.Get(searchindDirection).Get(positionX + 1).Contains('#')) then
                    exit(true);
                searchindDirection += 1;
            end;
        end;

        if directionY = 1 then begin
            if positionY - 1 < 1 then exit(false);
            if positionX - 1 < 1 then exit(false);

            searchindDirection := positionX - 1;
            while searchindDirection > 0 do begin
                if (MAP.Get(positionY - 1).Get(searchindDirection).Contains('<')) or (MAP.Get(searchindDirection).Get(positionX + 1).Contains('#')) then
                    exit(true);
                searchindDirection -= 1;
            end;
        end;


        exit(false);
    end;
}
