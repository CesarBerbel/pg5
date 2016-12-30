unit ufpgContatoRepositorio;

interface

uses
  Classes, SysUtils, uspRepositorio;

type

  TfpgContatoRepositorio = class(TspRepositorio)
  private
    fbTemCPF: boolean;
  public
    constructor Create; override;

  published
    property fpgTemCPF: boolean read fbTemCPF write fbTemCPF;
  end;

implementation

constructor TfpgContatoRepositorio.Create;
begin
  inherited;
  spCategoria := 'Pessoa';
  fbTemCPF := False;
end;

end.

