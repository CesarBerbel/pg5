unit ufpgPessoaRepositorio;

interface

uses
  Classes, SysUtils, uspRepositorio;

type

  TfpgPessoaRepositorio = class(TspRepositorio)
  private
    fbTemOAB: boolean;
    fbTemCPF: boolean;
    fbTemCNPJ: boolean;
  public
    constructor Create; override;

  published
    property fpgTemOAB: boolean read fbTemOAB write fbTemOAB;
    property fpgTemCPF: boolean read fbTemCPF write fbTemCPF;
    property fpgTemCNPJ: boolean read fbTemCNPJ write fbTemCNPJ;
  end;


implementation

constructor TfpgPessoaRepositorio.Create;
begin
  inherited;
  spCategoria := 'Pessoa';
  fbTemOAB := False;
  fbTemCPF := False;
  fbTemCNPJ := False;
end;

end.

