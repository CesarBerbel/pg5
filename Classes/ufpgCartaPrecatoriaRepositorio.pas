unit ufpgCartaPrecatoriaRepositorio;

interface

uses
  Classes, SysUtils, uspRepositorio, ufpgDocumentoRepositorio;

type
  TfpgCartaPrecatoriaRepositorio = class(TfpgDocumentoRepositorio)
  private
    FnQtdePessoasSelecionadas: integer;
    function GetFnQtdePessoasSelecionadas: integer;
  public
    constructor Create; override;
  published
    property fpgQtdePessoasSelecionadas: integer 
      read GetFnQtdePessoasSelecionadas   write FnQtdePessoasSelecionadas;
  end;

implementation

{ TfpgCartaPrecatoriaRepositorio }

constructor TfpgCartaPrecatoriaRepositorio.Create;
begin
  inherited;
  FnQtdePessoasSelecionadas := 1;
end;

function TfpgCartaPrecatoriaRepositorio.GetFnQtdePessoasSelecionadas: integer;
begin
  result := -1;
  if FnQtdePessoasSelecionadas > 0 then
    result := FnQtdePessoasSelecionadas;
end;

end.

