unit ufpgMandadoPrisaoRepositorio;

interface

uses
  Classes, SysUtils, uspRepositorio, Forms, ufpgEdicaoDocumento, ufpgMandadoRepositorio,
  uaipCadCapitulaEvento, TestFramework, uspFuncoes;

type

  TfpgMandadoPrisaoRepositorio = class(TfpgMandadoRepositorio)
  private
    FnCdTipoDePrisao: integer;
    FnCdRegime: integer;
    FdValidadeMandado: TDateTime;
    FnQtdePessoasSelecionadas: integer;
  public
    constructor Create; override;
  published
    property fpgValidadeMandado: TDateTime read FdValidadeMandado write FdValidadeMandado;
    property fpgCdTipoDePrisao: integer read FnCdTipoDePrisao write FnCdTipoDePrisao;
    property fpgQtdePessoasSelecionadas: integer 
      read FnQtdePessoasSelecionadas   write FnQtdePessoasSelecionadas;
  end;

implementation

{ TfpgMandadoPrisaoRepositorio }

constructor TfpgMandadoPrisaoRepositorio.Create;
begin
  inherited;
  FnCdTipoDePrisao := 0;
  FnCdRegime := 0;
  FdValidadeMandado := Date + 1;
  FnQtdePessoasSelecionadas := 1;
end;

end.

