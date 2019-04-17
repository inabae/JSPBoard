package DB;

public class page {
	public static void main(String[] args) {
		int page = 2;
		
		int total = 32; //전체 게시물 수
		int totalpage = 0; //전체 페이지 수
		
		if(total % 10 == 0) {
			totalpage = total / 10;
		}else {
			totalpage = total / 10 + 1;
		}
		System.out.println(totalpage);
		
		int startRow = 0;
		int endRow = 0;
		endRow = page * 10;
		startRow = endRow - 9;
		
		System.out.println(startRow);
		System.out.println(endRow);

		int startpage = 0;
		startpage = (page - 1) / 10 * 10 + 1;
		int endpage = 0;
		endpage = startpage + 9;
		
		if(endpage > totalpage) {
			endpage = totalpage;
		}
		
		System.out.println(startpage);
		System.out.println(endpage);
	}

}
