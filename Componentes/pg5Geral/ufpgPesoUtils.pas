unit ufpgPesoUtils;

interface

type
  TfpgValidaCompensaPeso = class(TObject)
  private
    FnPesoVaraQtTotal: integer;
    FnPesoCartorioQtTotal: integer;
    FnPesoVagaQtTotal: integer;
    FnPesoGlobalCartQtPesoGlobal: integer;
    FnPesoGlobalVaraQtPesoGlobal: integer;
    FnPesoVaraQtSaidoMoviment: integer;
    FnPesoVagaQtSaidoMoviment: integer;
    FnPesoCartorioQtSaidoMoviment: integer;
  public
    /// <summary>
    ///  Pegar resultados de pesos para comparação futura.
    /// </summary>
    /// <param name="pnCdForo">
    /// </param>
    /// <param name="pnCdVara">
    /// </param>
    /// <param name="pnCdVaga">
    /// </param>
    /// <param name="pnCdCartorio">
    /// </param>
    /// <param name="pnCdGrupoPeso">
    /// </param>
    /// <returns>
    ///  None
    /// </returns>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    procedure PegarResultados(const pnCdForo, pnCdVara, pnCdVaga, pnCdCartorio,
      pnCdGrupoPeso: integer);
    /// <summary>
    ///  Comparação de igualdade de valores.
    /// </summary>
    /// <param name="poValor">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    function TestarIgualdadeDePeso(const poValor: TfpgValidaCompensaPeso): boolean;
    /// <summary>
    ///  Teste se houve adição de peso.
    /// </summary>
    /// <param name="poValor">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    function TestarAdicaoDePeso(const poValor: TfpgValidaCompensaPeso): boolean; dynamic;
    /// <summary>
    ///  Teste se houve subtração de peso.
    /// </summary>
    /// <param name="poValor">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    function TestarSubtracaoDePeso(const poValor: TfpgValidaCompensaPeso): boolean; dynamic;
  published
    /// <summary>
    ///  Qtd. de peso total para vara.
    /// </summary>
    /// <value>
    ///  integer
    /// </value>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    property fpgPesoVaraQtTotal: integer read FnPesoVaraQtTotal write FnPesoVaraQtTotal;
    /// <summary>
    ///  Qtd. de peso total para vaga.
    /// </summary>
    /// <value>
    ///  integer
    /// </value>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    property fpgPesoVagaQtTotal: integer read FnPesoVagaQtTotal write FnPesoVagaQtTotal;
    /// <summary>
    ///  Qtd. de peso total para cartório.
    /// </summary>
    /// <value>
    ///  integer
    /// </value>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    property fpgPesoCartorioQtTotal: integer read FnPesoCartorioQtTotal 
      write FnPesoCartorioQtTotal;
    /// <summary>
    ///  Qtd. de movimento de saída para vara.
    /// </summary>
    /// <value>
    ///  integer
    /// </value>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    property fpgPesoVaraQtSaidoMoviment: integer 
      read FnPesoVaraQtSaidoMoviment   write FnPesoVaraQtSaidoMoviment;
    /// <summary>
    ///  Qtd. de movimento de saída para vaga.
    /// </summary>
    /// <value>
    ///  integer
    /// </value>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    property fpgPesoVagaQtSaidoMoviment: integer 
      read FnPesoVagaQtSaidoMoviment   write FnPesoVagaQtSaidoMoviment;
    /// <summary>
    ///  Qtd. de movimento de saída para cartório.
    /// </summary>
    /// <value>
    ///  integer
    /// </value>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    property fpgPesoCartorioQtSaidoMoviment: integer   
      read FnPesoCartorioQtSaidoMoviment write FnPesoVagaQtSaidoMoviment;
    /// <summary>
    ///  Qtd. de peso global para vara.
    /// </summary>
    /// <value>
    ///  integer
    /// </value>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    property fpgPesoGlobalVaraQtPesoGlobal: integer   
      read FnPesoGlobalVaraQtPesoGlobal write FnPesoGlobalVaraQtPesoGlobal;
    /// <summary>
    ///  Qtd. de peso global para cartório.
    /// </summary>
    /// <value>
    ///  integer
    /// </value>
    /// <remarks>
    ///  21/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    property fpgPesoGlobalCartQtPesoGlobal: integer   
      read FnPesoGlobalCartQtPesoGlobal write FnPesoGlobalCartQtPesoGlobal;
  end;

  TfpgValidaCompensaPesoVaga = class(TfpgValidaCompensaPeso)
  public
    /// <summary>
    ///  Teste se houve adição de peso.
    /// </summary>
    /// <param name="poValor">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  25/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    function TestarAdicaoDePeso(const poValor: TfpgValidaCompensaPeso): boolean; override;
    /// <summary>
    ///  Teste se houve subtração de peso.
    /// </summary>
    /// <param name="poValor">
    /// </param>
    /// <returns>
    ///  boolean
    /// </returns>
    /// <remarks>
    ///  25/06/2013 - cleber.gomes - SALT: 61989/1
    /// </remarks>
    function TestarSubtracaoDePeso(const poValor: TfpgValidaCompensaPeso): boolean; override;
  end;

implementation

uses
  ufpgCadMovimentacaoUnitariaModelTests;

{ TfpgValidaCompensaPeso }

// 21/06/2013 - cleber.gomes - SALT: 61989/1
function TfpgValidaCompensaPeso.TestarIgualdadeDePeso(
  const poValor: TfpgValidaCompensaPeso): boolean;
var
  bFlag: boolean;
begin
  bFlag := (Self.fpgPesoVaraQtSaidoMoviment = poValor.fpgPesoVaraQtSaidoMoviment);
  bFlag := bFlag and (Self.fpgPesoVagaQtSaidoMoviment = poValor.fpgPesoVagaQtSaidoMoviment);
  bFlag := bFlag and (Self.fpgPesoCartorioQtSaidoMoviment =
    poValor.fpgPesoCartorioQtSaidoMoviment);

  bFlag := bFlag and (Self.fpgPesoVaraQtTotal = poValor.fpgPesoVaraQtTotal);
  bFlag := bFlag and (Self.fpgPesoVagaQtTotal = poValor.fpgPesoVagaQtTotal);
  bFlag := bFlag and (Self.fpgPesoCartorioQtTotal = poValor.fpgPesoCartorioQtTotal);
  bFlag := bFlag and (Self.fpgPesoGlobalVaraQtPesoGlobal = poValor.fpgPesoGlobalVaraQtPesoGlobal);
  bFlag := bFlag and (Self.fpgPesoGlobalCartQtPesoGlobal = poValor.fpgPesoGlobalCartQtPesoGlobal);

  result := bFlag;
end;

// 21/06/2013 - cleber.gomes - SALT: 61989/1
procedure TfpgValidaCompensaPeso.PegarResultados(
  const pnCdForo, pnCdVara, pnCdVaga, pnCdCartorio, pnCdGrupoPeso: integer);
begin
  TffpgCadMovimentacaoUnitariaModelTests.PegarPesoCartorio(pnCdForo, pnCdCartorio,
    pnCdGrupoPeso, Self.FnPesoCartorioQtSaidoMoviment, Self.FnPesoCartorioQtTotal);

  TffpgCadMovimentacaoUnitariaModelTests.PegarPesoVaga(pnCdForo, pnCdVara,
    pnCdVaga, pnCdGrupoPeso, Self.FnPesoVagaQtSaidoMoviment, Self.FnPesoVagaQtTotal);

  TffpgCadMovimentacaoUnitariaModelTests.PegarPesoVara(pnCdForo, pnCdVara,
    pnCdGrupoPeso, Self.FnPesoVaraQtSaidoMoviment, Self.FnPesoVaraQtTotal);

  TffpgCadMovimentacaoUnitariaModelTests.PegarPesoGlobalVara(pnCdForo, pnCdVara,
    Self.FnPesoGlobalVaraQtPesoGlobal);

  TffpgCadMovimentacaoUnitariaModelTests.PegarPesoGlobalCartorio(pnCdForo,
    pnCdCartorio, Self.FnPesoGlobalCartQtPesoGlobal);
end;

// 21/06/2013 - cleber.gomes - SALT: 61989/1
function TfpgValidaCompensaPeso.TestarAdicaoDePeso(const poValor: TfpgValidaCompensaPeso): boolean;
var
  bFlag: boolean;
begin
  // - Subtrair um nos campos:
  bFlag := (Self.fpgPesoVaraQtSaidoMoviment = poValor.fpgPesoVaraQtSaidoMoviment);
  bFlag := bFlag and (Self.fpgPesoVagaQtSaidoMoviment = poValor.fpgPesoVagaQtSaidoMoviment);
  bFlag := bFlag and (Self.fpgPesoCartorioQtSaidoMoviment =
    poValor.fpgPesoCartorioQtSaidoMoviment);

  // - Adicionar um nos campos:
  bFlag := bFlag and ((Self.fpgPesoVaraQtTotal + 1) = poValor.fpgPesoVaraQtTotal);
  bFlag := bFlag and ((Self.fpgPesoVagaQtTotal + 1) = poValor.fpgPesoVagaQtTotal);
  bFlag := bFlag and ((Self.fpgPesoCartorioQtTotal + 1) = poValor.fpgPesoCartorioQtTotal);
  bFlag := bFlag and ((Self.fpgPesoGlobalVaraQtPesoGlobal + 1) =
    poValor.fpgPesoGlobalVaraQtPesoGlobal);
  bFlag := bFlag and ((Self.fpgPesoGlobalCartQtPesoGlobal + 1) =
    poValor.fpgPesoGlobalCartQtPesoGlobal);
  result := bFlag;
end;

// 21/06/2013 - cleber.gomes - SALT: 61989/1
function TfpgValidaCompensaPeso.TestarSubtracaoDePeso(
  const poValor: TfpgValidaCompensaPeso): boolean;
var
  bFlag: boolean;
begin
  // - Subtrair um nos campos:
  bFlag := (Self.fpgPesoVaraQtSaidoMoviment = poValor.fpgPesoVaraQtSaidoMoviment);
  bFlag := bFlag and (Self.fpgPesoVagaQtSaidoMoviment = poValor.fpgPesoVagaQtSaidoMoviment);
  bFlag := bFlag and (Self.fpgPesoCartorioQtSaidoMoviment =
    poValor.fpgPesoCartorioQtSaidoMoviment);

  // - Adicionar um nos campos:
  bFlag := bFlag and ((Self.fpgPesoVaraQtTotal - 1) = poValor.fpgPesoVaraQtTotal);
  bFlag := bFlag and ((Self.fpgPesoVagaQtTotal - 1) = poValor.fpgPesoVagaQtTotal);
  bFlag := bFlag and ((Self.fpgPesoCartorioQtTotal - 1) = poValor.fpgPesoCartorioQtTotal);
  bFlag := bFlag and ((Self.fpgPesoGlobalVaraQtPesoGlobal - 1) =
    poValor.fpgPesoGlobalVaraQtPesoGlobal);
  bFlag := bFlag and ((Self.fpgPesoGlobalCartQtPesoGlobal - 1) =
    poValor.fpgPesoGlobalCartQtPesoGlobal);
  result := bFlag;
end;

{ TfpgValidaCompensaPesoVaga }

function TfpgValidaCompensaPesoVaga.TestarAdicaoDePeso(
  const poValor: TfpgValidaCompensaPeso): boolean;
var
  bFlag: boolean;
begin
  // - Subtrair um nos campos:
  bFlag := (Self.fpgPesoVaraQtSaidoMoviment = poValor.fpgPesoVaraQtSaidoMoviment);
  bFlag := bFlag and (Self.fpgPesoVagaQtSaidoMoviment = poValor.fpgPesoVagaQtSaidoMoviment);
  bFlag := bFlag and (Self.fpgPesoCartorioQtSaidoMoviment =
    poValor.fpgPesoCartorioQtSaidoMoviment);

  // - Adicionar um nos campos:
  bFlag := bFlag and (Self.fpgPesoVaraQtTotal = poValor.fpgPesoVaraQtTotal);
  bFlag := bFlag and ((Self.fpgPesoVagaQtTotal + 1) = poValor.fpgPesoVagaQtTotal);
  bFlag := bFlag and (Self.fpgPesoCartorioQtTotal = poValor.fpgPesoCartorioQtTotal);
  bFlag := bFlag and (Self.fpgPesoGlobalVaraQtPesoGlobal = poValor.fpgPesoGlobalVaraQtPesoGlobal);
  bFlag := bFlag and (Self.fpgPesoGlobalCartQtPesoGlobal = poValor.fpgPesoGlobalCartQtPesoGlobal);
  result := bFlag;
end;

function TfpgValidaCompensaPesoVaga.TestarSubtracaoDePeso(
  const poValor: TfpgValidaCompensaPeso): boolean;
var
  bFlag: boolean;
begin
  // - Subtrair um nos campos:
  bFlag := (Self.fpgPesoVaraQtSaidoMoviment = poValor.fpgPesoVaraQtSaidoMoviment);
  bFlag := bFlag and (Self.fpgPesoVagaQtSaidoMoviment = poValor.fpgPesoVagaQtSaidoMoviment);
  bFlag := bFlag and (Self.fpgPesoCartorioQtSaidoMoviment =
    poValor.fpgPesoCartorioQtSaidoMoviment);

  // - Adicionar um nos campos:
  bFlag := bFlag and (Self.fpgPesoVaraQtTotal = poValor.fpgPesoVaraQtTotal);
  bFlag := bFlag and ((Self.fpgPesoVagaQtTotal - 1) = poValor.fpgPesoVagaQtTotal);
  bFlag := bFlag and (Self.fpgPesoCartorioQtTotal = poValor.fpgPesoCartorioQtTotal);
  bFlag := bFlag and (Self.fpgPesoGlobalVaraQtPesoGlobal = poValor.fpgPesoGlobalVaraQtPesoGlobal);
  bFlag := bFlag and (Self.fpgPesoGlobalCartQtPesoGlobal = poValor.fpgPesoGlobalCartQtPesoGlobal);
  result := bFlag;
end;

end.

