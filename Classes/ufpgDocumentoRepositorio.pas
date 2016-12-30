unit ufpgDocumentoRepositorio;

interface

uses
  Classes, SysUtils, uspRepositorio;

type
  TTipoOperacao = (topFinalizar, topAssinar, topLiberarNosAutos, topAssinarELiberar);

type

  TfpgDocumentoRepositorio = class(TspRepositorio)
  private
    FnTipoModelo: integer;
    FnTipoCategoria: integer;
    FopAssinatura: TTipoOperacao;
    procedure SetarFnTipoCategoria(const pnTipoCategoria: integer);
    procedure SetarFnTipoModelo(const pnTipoModelo: integer);
  public
    constructor Create; override;
  published
    property fpgTipoCategoria: integer read FnTipoCategoria write SetarFnTipoCategoria;
    property fpgTipoModelo: integer read FnTipoModelo write SetarFnTipoModelo;
    property TipoAssinatura: TTipoOperacao read FopAssinatura write FopAssinatura;
  end;

implementation


{ TfpgDocumentoRepositorio }

constructor TfpgDocumentoRepositorio.Create;
begin
  inherited;
  spCategoria := 'Documento';
  FnTipoModelo := 0;
  FnTipoCategoria := 0;
end;

procedure TfpgDocumentoRepositorio.SetarFnTipoCategoria(const pnTipoCategoria: integer);
begin
  FnTipoCategoria := pnTipoCategoria;
  AdicionarPropriedadeConsiderada('fpgTipoCategoria');
end;

procedure TfpgDocumentoRepositorio.SetarFnTipoModelo(const pnTipoModelo: integer);
begin
  FnTipoModelo := pnTipoModelo;
  AdicionarPropriedadeConsiderada('fpgTipoModelo');
end;

end.

