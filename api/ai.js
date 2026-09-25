// =============================================================================
// VERCEL SERVERLESS FUNCTION: /api/ai
// Tích hợp Google Gemini AI bảo mật cho RK Workspace Learning Dashboard & Chatbot
// =============================================================================

const DEFAULT_GEMINI_KEY = process.env.GEMINI_API_KEY || Buffer.from('QVEuQWI4Uk42S0dFSm5pV3o5TjBHQW9XM0MzOVJOaWpoMnN4QjJPYU1wdXN6b2ZmM0F6cnc=', 'base64').toString('utf-8');
const CANDIDATE_MODELS = ['gemini-3.1-flash-lite', 'gemini-3.8-flash', 'gemma-4-26b-a4b-it'];

export default async function handler(req, res) {
  // Thiết lập CORS header cho phép gọi từ mọi client
  res.setHeader('Access-Control-Allow-Credentials', true);
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET,OPTIONS,PATCH,DELETE,POST,PUT');
  res.setHeader(
    'Access-Control-Allow-Headers',
    'X-CSRF-Token, X-Requested-With, Accept, Accept-Version, Content-Length, Content-MD5, Content-Type, Date, X-Api-Version'
  );

  if (req.method === 'OPTIONS') {
    res.status(200).end();
    return;
  }

  if (req.method === 'GET') {
    res.status(200).json({
      status: 'online',
      provider: 'Google Gemini AI',
      hasSystemKey: true,
      model: process.env.GEMINI_MODEL || CANDIDATE_MODELS[0]
    });
    return;
  }

  if (req.method !== 'POST') {
    res.status(405).json({ error: 'Phương thức không được hỗ trợ. Vui lòng dùng POST.' });
    return;
  }

  try {
    const { action, sql, btvnTitle, schema, customKey, message } = req.body || {};
    
    // Ưu tiên key từ biến môi trường Vercel, fallback customKey hoặc DEFAULT_GEMINI_KEY
    const apiKey = process.env.GEMINI_API_KEY || customKey || DEFAULT_GEMINI_KEY;
    const requestedModel = process.env.GEMINI_MODEL || CANDIDATE_MODELS[0];

    // Chỉ bắt buộc có SQL khi là các tác vụ phân tích code, còn chat thì linh hoạt
    if (action !== 'chat' && (!sql || !sql.trim())) {
      res.status(400).json({
        error: 'Vui lòng nhập câu lệnh SQL vào ô soạn thảo trước khi yêu cầu AI phân tích.'
      });
      return;
    }

    if (action === 'chat' && (!message || !message.trim()) && (!sql || !sql.trim())) {
      res.status(400).json({
        error: 'Vui lòng nhập nội dung câu hỏi cho Trợ giảng AI.'
      });
      return;
    }

    // Xây dựng prompt chuyên môn dựa trên hành động được chọn
    let systemInstruction = `Bạn là Trợ giảng AI chuyên gia Cơ sở dữ liệu, SQL và Lập trình của Rikkei Academy. Đang hỗ trợ học viên học tập bài: "${btvnTitle || 'Bài tập CSDL'}".`;
    
    let prompt = '';
    switch (action) {
      case 'chat': {
        const userQuestion = message || 'Giải thích mã SQL hiện tại';
        let sqlContext = '';
        if (sql && sql.trim()) {
          sqlContext = `\n[Mã SQL học viên đang viết trong ô soạn thảo]:\n\`\`\`sql\n${sql.trim()}\n\`\`\`\n`;
        }
        prompt = `
${systemInstruction}
Nội dung bài tập đang chọn: ${btvnTitle || 'Tổng quan'}
Cấu trúc bảng (schema nếu có): ${schema || 'Theo bài tập'}
${sqlContext}
Câu hỏi của học viên:
"${userQuestion}"

Yêu cầu phản hồi:
1. Trả lời bằng tiếng Việt sư phạm, thân thiện, rõ ràng, tập trung vào trọng tâm (chuẩn phong cách /rk-ui tối giản).
2. Nếu đưa ra code mẫu SQL, hãy bao bọc trong khối \`\`\`sql ... \`\`\` với chú thích ngắn gọn từng câu lệnh.
3. Hướng dẫn học viên hiểu bản chất logic và cách sửa lỗi thay vì chỉ đưa ra đáp án sẵn.
`;
        break;
      }

      case 'score':
        prompt = `
${systemInstruction}
Nhiệm vụ: Chấm điểm câu lệnh SQL dưới đây theo thang điểm 10.
Nội dung bài tập: ${btvnTitle}
Cấu trúc bảng tham chiếu: ${schema || 'Theo đề bài'}
Mã SQL học viên viết:
\`\`\`sql
${sql}
\`\`\`

Yêu cầu xuất ra định dạng rõ ràng:
1. ĐIỂM SỐ: [X/10]
2. ĐÁNH GIÁ CHUNG: Tóm tắt 2-3 câu về mức độ chính xác của câu lệnh.
3. ƯU ĐIỂM: Những điểm làm đúng (cú pháp, ràng buộc, tối ưu).
4. NHƯỢC ĐIỂM HOẶC LỖI CẦN CẢI THIỆN (nếu có).
5. GỢI Ý NÂNG CAO: Cách viết chuẩn hơn hoặc tối ưu hơn theo MySQL 8.0.
`;
        break;

      case 'explain':
        prompt = `
${systemInstruction}
Nhiệm vụ: Giải thích chi tiết, dễ hiểu từng câu lệnh SQL cho người mới bắt đầu học.
Mã SQL học viên viết:
\`\`\`sql
${sql}
\`\`\`

Yêu cầu:
- Giải thích mục đích của từng khối lệnh (CREATE, INSERT, SELECT, JOIN, GROUP BY...).
- Chỉ rõ cách MySQL thực thi từng bước (Pipeline) và ý nghĩa của từng mệnh đề.
- Ngôn ngữ: Tiếng Việt sư phạm, dễ hiểu, thân thiện.
`;
        break;

      case 'fix':
        prompt = `
${systemInstruction}
Nhiệm vụ: Kiểm tra lỗi cú pháp, logic hoặc vi phạm ràng buộc trong câu lệnh SQL và đưa ra bản sửa hoàn chỉnh.
Mã SQL học viên viết:
\`\`\`sql
${sql}
\`\`\`

Yêu cầu:
1. CHỈ RA LỖI (nếu có): Vị trí dòng lỗi và nguyên nhân (ví dụ thiếu dấu phẩy, sai kiểu dữ liệu, thiếu WHERE, sai tên cột...).
2. BẢN CODE ĐÃ SỬA HOÀN CHỈNH (trong khối \`\`\`sql ... \`\`\`): Chạy được ngay 100% trên MySQL 8.0.
3. LƯU Ý KHI LÀM BÀI: Mẹo tránh mắc lại lỗi tương tự.
`;
        break;

      case 'design':
        prompt = `
${systemInstruction}
Nhiệm vụ: Đánh giá thiết kế cơ sở dữ liệu và cấu trúc bảng của học viên.
Mã SQL học viên viết:
\`\`\`sql
${sql}
\`\`\`

Yêu cầu:
1. ĐÁNH GIÁ MÔ HÌNH: Khóa chính (PRIMARY KEY), khóa ngoại (FOREIGN KEY), các ràng buộc (NOT NULL, CHECK, UNIQUE, DEFAULT).
2. MỨC ĐỘ CHUẨN HOÁ: Đánh giá đạt chuẩn 1NF, 2NF, 3NF hay chưa? Có bị dư thừa dữ liệu không?
3. KHẢ NĂNG MỞ RỘNG VÀ ĐÁNH CHỈ MỤC (INDEX): Gợi ý thêm index hoặc tối ưu kiểu dữ liệu nếu cần.
`;
        break;

      default:
        prompt = `
${systemInstruction}
Hãy phân tích và đưa ra nhận xét chuyên môn về câu lệnh SQL sau:
\`\`\`sql
${sql}
\`\`\`
`;
    }

    // Cơ chế retry các model khả dụng để đảm bảo độ tin cậy 100%
    const modelsToTry = [requestedModel, ...CANDIDATE_MODELS.filter(m => m !== requestedModel)];
    let lastError = null;

    for (const model of modelsToTry) {
      const geminiUrl = `https://generativelanguage.googleapis.com/v1beta/models/${model}:generateContent?key=${apiKey}`;

      try {
        const response = await fetch(geminiUrl, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json'
          },
          body: JSON.stringify({
            contents: [
              {
                parts: [
                  { text: prompt }
                ]
              }
            ],
            generationConfig: {
              temperature: 0.3,
              maxOutputTokens: 2048
            }
          })
        });

        const data = await response.json();

        if (response.ok) {
          const replyText = data.candidates?.[0]?.content?.parts?.[0]?.text;
          if (replyText) {
            res.status(200).json({
              success: true,
              result: replyText,
              provider: 'Google Gemini AI (' + model + ')'
            });
            return;
          }
        } else {
          lastError = data.error?.message || `Lỗi từ Google Gemini (Mã: ${response.status})`;
        }
      } catch (err) {
        lastError = err.message || err;
      }
    }

    res.status(500).json({
      error: 'Không thể kết nối tới Google Gemini AI: ' + (lastError || 'Lỗi không xác định')
    });
  } catch (error) {
    res.status(500).json({
      error: 'Lỗi máy chủ nội bộ khi kết nối AI: ' + (error.message || error)
    });
  }
}
