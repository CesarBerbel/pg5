unit ufpgRelEtiqAutuacaoBlocoModelTests;

interface

uses
  // 01/09/2014 - douglas.delapria - SALT: 145483/1
  ufpgDataModelTests;

type
  TffpgRelEtiqAutuacaoBlocoModelTests = class(TspDataModelTests)
  private
    // 27/08/2014 - douglas.delapria - SALT: 145483/1
    FsNuProcesso: string;
    /// <summary>
    ///  Seta valor para property
    /// </summary>
    /// <param name="Value">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    /// 01/09/2014 - douglas.delapria - SALT: 145483/1
    /// </remarks>
    procedure SetfpgNuProcesso(const Value: string);
  published
    // 01/09/2014 - douglas.delapria - SALT: 145483/1
    property fpgNuProcesso: string read FsNuProcesso write SetfpgNuProcesso;
  end;

implementation

{ TffpgRelEtiqAutuacaoBlocoModelTests }

// 01/09/2014 - douglas.delapria - SALT: 145483/1
procedure TffpgRelEtiqAutuacaoBlocoModelTests.SetfpgNuProcesso(const Value: string);
begin
  FsNuProcesso := Value;
end;

end.

