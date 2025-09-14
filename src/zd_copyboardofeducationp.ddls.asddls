@EndUserText.label: 'Copy Board of Education'
define abstract entity ZD_CopyBoardOfEducationP
{
  @EndUserText.label: 'New Board'
  @UI.defaultValue: #( 'ELEMENT_OF_REFERENCED_ENTITY: Board' )
  Board : ZBOARD;
}
