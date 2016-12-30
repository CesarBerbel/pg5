unit ufpgMandadoRepositorio;

interface

uses
  Classes, SysUtils, uspRepositorio, ufpgDocumentoRepositorio, uggpFuncoes;

type

  TfpgMandadoRepositorio = class(TfpgDocumentoRepositorio)
  private
    FbNaoSeraCumpridoPeloOficialDeJustica: boolean;
    FnCdClassificacao: integer;
  public
    constructor Create; override;
  published
    property fpgCdClassificacao: integer read FnCdClassificacao write FnCdClassificacao;
    property fpgNaoSeraCumpridoPeloOficialDeJustica: boolean   
      read FbNaoSeraCumpridoPeloOficialDeJustica write FbNaoSeraCumpridoPeloOficialDeJustica;
  end;

implementation

{ TfpgMandadoRepositorio }

constructor TfpgMandadoRepositorio.Create;
begin
  inherited;
  fpgTipoCategoria := StrToInt(RetornarCodigoMandadoPrisao);
  FbNaoSeraCumpridoPeloOficialDeJustica := False;
  FnCdClassificacao := 0;
end;

end.

