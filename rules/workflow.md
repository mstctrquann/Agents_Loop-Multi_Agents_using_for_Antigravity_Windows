---
trigger: always_on
description: Advanced Multi-Agent Refinement Loop & Dynamic Tier Workflow
---
# Advanced Multi-Agent Refinement Loop & Tier Workflow

Khi nhận lệnh `/goal` hoặc mục tiêu kỹ thuật mới:
BẮT BUỘC tuân thủ chu trình phối hợp đa tác tử khép kín (Critic-in-the-Loop) theo các bước:

## Giai đoạn 1: Chuẩn bị & Kiến trúc
1. `@code-worker`: Thu thập context codebase, logs, dependency, trích xuất vào `SPEC_DIGEST.md`.
2. `@architect-reviewer`: Phản biện rủi ro, edge cases và lỗ hổng tiềm ẩn vào `SPEC_FEEDBACK.md`.
3. `@architect-lead`: Chốt giải pháp kiến trúc tối ưu vào `ARCH_PLAN.md`.
4. `@code-worker`: Phân rã checklist công việc chi tiết vào `TASKS.md`.

## Giai đoạn 2: Thực thi & Actor-Critic Loop (Tối đa 3 vòng lặp)
5. `@code-worker`: Viết code và chạy unit/integration test.
6. **Frontier Reviewer (@architect-reviewer / Frontier Model)** thẩm định diff và kết quả test:
   - Nếu còn lỗi hoặc phát hiện bug logic: Cung cấp danh sách yêu cầu khắc phục ngắn gọn và trả về cho `@code-worker` sửa lại.
   - Vòng lặp sửa code - review tiếp tục cho đến khi:
     a) Tất cả test đều pass VÀ `@architect-reviewer` xác nhận `STATUS: APPROVED`.
     b) HOẶC đạt giới hạn tối đa `max_refinement_loops` (mặc định 3 vòng).

## Giai đoạn 3: Bàn giao & Tùy chọn tối ưu
7. Xuất file **`SESSION_LOG.md`** tổng kết:
   - Tóm tắt những module đã sửa đổi.
   - Các lỗi/vấn đề đã giải quyết qua từng vòng loop.
   - Trạng thái kiểm thử hiện tại.
   - Gợi ý 2-3 hướng người dùng có thể yêu cầu tối ưu tiếp (Performance, Security, Test Coverage, Refactoring).

Nghiêm cấm agent chính tự thực hiện toàn bộ mà không điều phối qua các subagent.
