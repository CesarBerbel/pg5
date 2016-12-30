unit ufpgRedistribuicaoEntreForosFake;

interface

uses
  ufpgRedistribuicaoEntreForos, uspConjuntoDados, uspServidorAplicacao;

type
  TfpgRedistribuicaoEntreForosFake = class(TfpgRedistribuicaoEntreForos)
  private
  public
    function TestarSeParametroDefaultOuSimFake(psNomeParametros: string;
      pbValorDefault: boolean; pocdsPrmAdicionais: TspConjuntoDados): boolean;
    constructor spCreate(AOwner: TspServidorAplicacao; const guid, DispIntf: TGUID); override;
  end;

implementation

{ TfpgRedistribuicaoEntreForosFake }

constructor TfpgRedistribuicaoEntreForosFake.spCreate(AOwner: TspServidorAplicacao;
  const guid, DispIntf: TGUID);
begin
  exit;
end;

function TfpgRedistribuicaoEntreForosFake.TestarSeParametroDefaultOuSimFake(
  psNomeParametros: string;
  pbValorDefault: boolean; pocdsPrmAdicionais: TspConjuntoDados): boolean;
begin
  result := TestarSeParametroDefaultOuSim(psNomeParametros, pbValorDefault, pocdsPrmAdicionais);
end;

end.

