# Multi-Agent Orchestration Guard Rules

MỖI KHI NHẬN LỆNH /goal HOẶC MỤC TIÊU MỚI:
Hệ thống BẮT BUỘC tự động kích hoạt quy trình phối hợp giữa các subagents theo các giai đoạn sau:

1. Giao @code-worker thu thập context/logs, trích xuất dữ liệu cô đọng vào SPEC_DIGEST.md.
2. Giao @architect-reviewer phản biện lỗ hổng kiến trúc/bottleneck vào SPEC_FEEDBACK.md.
3. Giao @architect-lead chốt phương án kỹ thuật tối ưu vào ARCH_PLAN.md.
4. Giao @code-worker băm nhỏ checklist trong TASKS.md và tiến hành code/test.
5. Vòng lặp phản biện (Actor-Critic Loop): Code worker sau khi ra kết quả sẽ được Frontier Reviewer thẩm định lại. Vòng lặp sửa lỗi thực hiện cho tới khi code đạt chuẩn (STATUS: APPROVED) hoặc đạt giới hạn loop (tối đa 3 vòng).
6. Xuất SESSION_LOG.md tổng kết các thay đổi, test pass, và các hướng tối ưu tiếp theo để người dùng lựa chọn.

Nghiêm cấm agent chính tự mình làm hết từ A-Z.
