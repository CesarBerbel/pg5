unit ufpgCorrecaoProcHibridoFake;

interface

uses
  ufpgCorrecaoProcHibrido, Windows, Forms, SysUtils;

type
  TfpgCorrecaoProcHibridoFake = class(TfpgCorrecaoProcHibrido)
  private
    FnQtdePecaFisica: integer;
  protected
    function PegarQtdePecaFisicaProcesso: integer; override;
    function TestarAlterarProcHibridoParaDigital: boolean; override;
  public
    constructor Create;

    function TestarNovoNumeroPrimeiraPaginaCPH(const psNovoNumeroPagina: string): boolean;
      override;

    property fpgQtdePecaFisica: integer read FnQtdePecaFisica write FnQtdePecaFisica;
  end;

implementation

uses
  usajConstante, uspExcecao, ufpgMensagem3;

{ TfpgCorrecaoProcHibridoFake }

constructor TfpgCorrecaoProcHibridoFake.Create;
begin
  FnQtdePecaFisica := 0;
end;

function TfpgCorrecaoProcHibridoFake.PegarQtdePecaFisicaProcesso: integer;
begin
  result := FnQtdePecaFisica;
end;

function TfpgCorrecaoProcHibridoFake.TestarNovoNumeroPrimeiraPaginaCPH(
  const psNovoNumeroPagina: string): boolean;
begin
  result := inherited TestarNovoNumeroPrimeiraPaginaCPH(psNovoNumeroPagina);
end;

function TfpgCorrecaoProcHibridoFake.TestarAlterarProcHibridoParaDigital: boolean;
begin
  result := True;
end;

end.

